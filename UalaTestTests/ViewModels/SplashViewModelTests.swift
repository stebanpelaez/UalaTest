//
//  SplashViewModelTests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import XCTest
import Combine

@testable import UalaTest

final class SplashViewModelTests: XCTestCase {
    
    func testDownloadData() {
        
        PreferencesManager.shared.downloadedData = false

        let viewModel = SplashViewModel(apiManager: MockApiService.shared, dataManager: MockDataManager.shared)
        
        viewModel.downloadData()
        
        XCTAssertTrue(PreferencesManager.shared.downloadedData)
    }
    
    
}
