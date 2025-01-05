//
//  ApiManagerTests.swift
//  UalaTestTests
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

import XCTest
import Combine

@testable import UalaTest

final class ApiManagerTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchDataGet() {
        
        let expectation = expectation(description: "Consume get service from server")
        
        let urlSessionMock = MockURLSession()
        urlSessionMock.data = try? JSONSerialization.data(withJSONObject: ConstantsMock.responseLocations)
        
        let apiManager = APIManager(session: urlSessionMock)
        
        let request = APIRequestBuilder(urlApi: ConstantsMock.apiBase)
            .withEndPoint(ConstantsMock.endPointCities)
            .withParams(["p": "q"])
            .withTimeOut(10)
            .withHeaders(["header1": "value1"])
            .build()
        
        apiManager.fetchData(request: request, type: [LocationItem].self)
            .sink {
                if case .failure(let error) = $0 {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { locations in
                XCTAssertFalse(locations.isEmpty)
                expectation.fulfill()
            }.store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    
    func testFetchDataPostError() {

        let expectation = expectation(description: "Consume post error reservice from server")
        
        let urlSessionMock = MockURLSession()
        urlSessionMock.error = APIError.unexpectedResponse
        
        let apiManager = APIManager(session: urlSessionMock)
        
        let request = APIRequestBuilder(urlApi: ConstantsMock.apiBase)
            .withEndPoint(ConstantsMock.endPointCities)
            .withMethod(.post)
            .withParams(["p": "q"])
            .withTimeOut(10)
            .withHeaders(["header1": "value1"])
            .build()
        
        apiManager.fetchData(request: request, type: [LocationItem].self)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            } receiveValue: { value in
                XCTFail("Expected error but got success: \(value)")
                
            }.store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 3.0)
    }

}
