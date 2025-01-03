//
//  APIService.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//
import Foundation
import Combine

protocol APIServiceProtocol: AnyObject {
    func fetchData<T: Decodable>(request: APIRequest, type: T.Type) -> Future<T, Error>
}

class APIService: APIServiceProtocol  {
    
    static let shared = APIService()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(request: APIRequest, type: T.Type) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            
            guard let self = self,
                  let path = URL.concatenateUrl(request.urlApi, finalPath: request.endPoint),
                  let pathUrl = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: pathUrl) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var urlRequest = URLRequest(url: url)
            
            if request.method == .get {
                if let urlGet = self.prepareParamsRequestGet(path: pathUrl, params: request.params) {
                    urlRequest = URLRequest(url: urlGet)
                }
            } else {
                do {
                    try self.setBodyToRequest(urlRequest: &urlRequest, headers: request.headers, body: request.params)
                } catch {
                    return promise(.failure(APIError.errorBody))
                }
            }
            
            urlRequest.httpMethod = request.method.rawValue
            
            self.setHeadersToRequest(urlRequest: &urlRequest, headers: request.headers)
            
            self.session
                .dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.unexpectedResponse
                    }
                    
                    guard HTTPCodes.success.contains(statusCode) else {
                        throw APIError.httpCode(statusCode)
                    }
                    
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as APIError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    internal func prepareParamsRequestGet(path: String, params: [AnyHashable: Any]) -> URL? {
        var newPath = path
        let queryParameters = params.queryParameters
        if !queryParameters.isEmpty {
            newPath = "\(path)?\(queryParameters)"
        }
        return URL(string: newPath)
    }
    
    internal func setHeadersToRequest(urlRequest: inout URLRequest, headers: [String: String]) {
        
        var headers = headers
        
        if headers[HTTPHeader.contentType] == nil {
            headers[HTTPHeader.contentType] = HTTPHeader.applicationJson
        }
        
        if headers[HTTPHeader.accept] == nil {
            headers[HTTPHeader.accept] = HTTPHeader.applicationJson
        }
        
        urlRequest.allHTTPHeaderFields = headers
    }
    
    internal func setBodyToRequest(urlRequest: inout URLRequest, headers: [String: String], body: [AnyHashable: Any]) throws {
        if let contentType = headers[HTTPHeader.contentType], contentType == HTTPHeader.urlEncoded, let newBody = body as? [String: String] {
            var urlComponents = URLComponents()
            urlComponents.queryItems = newBody.map { URLQueryItem(name: $0.key, value: $0.value) }
            urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        } else {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
    }
    
}
