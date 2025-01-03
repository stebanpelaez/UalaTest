//
//  APIRequest.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

struct APIRequest {
    var method: HttpMethod
    var urlApi: String
    var endPoint: String
    var timeOut: Double
    var headers: [String: String] = [:]
    var params: [AnyHashable: Any] = [:]
}

class APIRequestBuilder {

    private var apiRequest: APIRequest

    public init(urlApi: String) {
        self.apiRequest = APIRequest(method: .get, urlApi: urlApi, endPoint: "", timeOut: 30.0)
    }

    public func withMethod(_ method: HttpMethod) -> APIRequestBuilder {
        self.apiRequest.method = method
        return self
    }

    public func withEndPoint(_ endPoint: String) -> APIRequestBuilder {
        self.apiRequest.endPoint = endPoint
        return self
    }

    public func withTimeOut(_ timeOut: Double) -> APIRequestBuilder {
        self.apiRequest.timeOut = timeOut
        return self
    }

    public func withHeaders(_ headers: [String: String]) -> APIRequestBuilder {
        self.apiRequest.headers = headers
        return self
    }

    public func withParams(_ params: [AnyHashable: Any]) -> APIRequestBuilder {
        self.apiRequest.params = params
        return self
    }

    public func build() -> APIRequest {
        return self.apiRequest
    }

}
