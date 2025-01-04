//
//  URLSessionMock.swift
//  vssh-ios-communicationTests
//
//  Created by Juan Esteban Peláez Martínez on 23/04/23.
//

import Foundation

class MockURLSession: URLSession, @unchecked Sendable {
    
    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask {
            let response = HTTPURLResponse(url: request.url!, statusCode: error == nil ? 200: 404, httpVersion: "HTTP/1.1", headerFields: ConstantsMock.headers)!
            completionHandler(data, response, error)
        }
    }
    
}

class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
    
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        self.closure()
    }
}

