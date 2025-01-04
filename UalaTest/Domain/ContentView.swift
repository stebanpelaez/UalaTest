//
//  ContentView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var preferencesManager = PreferencesManager.shared
    
    /// Si ya descargo la data me muestra la lista de ciudades, si es primera vez o se borraron los datos se muestra el Splash para conectarse a la red y realizar la respectiva descarga
    var body: some View {
        if self.preferencesManager.downloadedData {
            CitiesView()
        } else {
            SplashView()
        }
    }
    
}
