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
                
        let apiManager = MockApiManager.shared
        apiManager.mock = MockHelper.listLocation
        
        let viewModel = SplashViewModel(apiManager: apiManager, dataManager: MockDataManager.shared)
        
        PreferencesManager.shared.downloadedData = true
        viewModel.downloadData()
        
        PreferencesManager.shared.downloadedData = false
        viewModel.downloadData()
            
        XCTAssertFalse(PreferencesManager.shared.downloadedData)
    }
    
}
