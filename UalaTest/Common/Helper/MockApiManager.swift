//
//  MockApiManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//
import Foundation
import Combine

/// Mocks para las #Previews y pruebas unitarias
class MockApiManager: APIManagerProtocol {
    
    static let shared = MockApiManager()
    
    var mock: Any?
    
    func fetchData<T: Decodable>(request: APIRequest, type: T.Type) -> Future<T, Error> {
        return Future { promise in
            if let response = self.mock as? T {
                promise(.success(response))
            } else {
                promise(.failure(NSError(domain: "MockApiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid mock response"])))
            }
        }
    }
    
}
