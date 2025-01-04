//
//  UalaTestUITests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import XCTest
import ViewInspector

@testable import UalaTest

final class UalaTestUITests: XCTestCase {
    
    func testContentView() throws {
        
        PreferencesManager.shared.downloadedData = false
        
        let sut = ContentView()
        
        let sutSplash = try sut.inspect().find(SplashView.self).actualView()
        let valueSplash = try sutSplash.inspect().implicitAnyView().vStack().text(1).string()
        XCTAssertEqual(valueSplash, "Downloading cities...")
        
        PreferencesManager.shared.downloadedData = true
        
        let citiesView = try sut.inspect().find(CitiesView.self).actualView()
        let value = try citiesView.inspect().implicitAnyView().text().string()
        XCTAssertEqual(value, "CitiesView")
    }
    
}
