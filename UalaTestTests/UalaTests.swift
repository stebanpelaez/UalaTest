//
//  UalaTests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import Combine
import XCTest

@testable import UalaTest

final class UalaTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testURLExtension() {
        let url = URL.concatenateUrl(nil, finalPath: ConstantsMock.endPointCities)
        XCTAssertNotNil(url)
        
        let url2 = URL.concatenateUrl("test", finalPath: ConstantsMock.endPointCities)
        XCTAssertNotNil(url2)
        
        let url3 = URL.concatenateUrl("test/", finalPath: "/test2")
        XCTAssertNotNil(url3)
        
        let url4 = URL.concatenateUrl("test/", finalPath: nil)
        XCTAssertNotNil(url4)
    }
    
    func testApiManagerExtension() {
        
        let errorInvalidURL = APIError.invalidURL
        XCTAssertEqual(errorInvalidURL.errorDescription, "Invalid URL")
        
        let errorUnknown = APIError.unknown
        XCTAssertEqual(errorUnknown.errorDescription, "Unknown")
        
        let errorUnexpectedResponse = APIError.unexpectedResponse
        XCTAssertEqual(errorUnexpectedResponse.errorDescription, "Unexpected response from the server")
        
        let errorCode = APIError.httpCode(404)
        XCTAssertEqual(errorCode.errorDescription, "Unexpected HTTP code: 404")
    }
    
    func testHelperMock() {
        
        let dataManager = MockDataManager.shared
        dataManager.add([])
        _ = dataManager.fetch(withSearch: "")
        _ = dataManager.fetchFavourites()
        dataManager.removeAll()
        
        
        let expectation = expectation(description: "Expectation Mock")
        
        let apiManager = MockApiManager.shared
        
        let request = APIRequestBuilder(urlApi: "").build()
        
        apiManager.fetchData(request: request, type: Bool.self)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error.localizedDescription, "Invalid mock response")
                    expectation.fulfill()
                }
            } receiveValue: { locations in
                XCTFail("Expected Error")
            }.store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 3.0)
    }
    
}
