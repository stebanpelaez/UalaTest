//
//  PreferencesManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

class PreferencesManager: ObservableObject {
    
    static let shared = PreferencesManager()
    
    /// Se usa esta variable para mostrar la vista de carga `SplasView` o la vista de la lista de ciudades en el `ContentView`, esta propiedad se guarda en los Defaults
    @AppStorage(Constants.downloadedData.rawValue)
    var downloadedData: Bool = false
    
}
