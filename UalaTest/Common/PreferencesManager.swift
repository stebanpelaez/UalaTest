//
//  PreferencesManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

class PreferencesManager: ObservableObject {
    
    static let shared = PreferencesManager()
    
    @AppStorage(Constants.downloadedData.rawValue)
    var downloadedData: Bool = false
    
}
