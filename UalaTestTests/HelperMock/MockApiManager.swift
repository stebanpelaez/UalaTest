//
//  MockApiManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//
import Foundation
import Combine

@testable import UalaTest

class MockApiService: APIManagerProtocol {
    
    static let shared = MockApiService()
    
    func fetchData<T: Decodable>(request: APIRequest, type: T.Type) -> Future<T, Error> {
        return Future { promise in
            if let response = MockHelper.listLocation as? T {
                promise(.success(response))
            } else {
                promise(.failure(NSError(domain: "MockAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid mock response"])))
            }
        }
    }
    
}
