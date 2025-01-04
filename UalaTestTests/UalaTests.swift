//
//  UalaTests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import XCTest

@testable import UalaTest

final class UalaTests: XCTestCase {
    
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
    
}
