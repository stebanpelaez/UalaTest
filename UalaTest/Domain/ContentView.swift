//
//  ContentView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var preferencesManager = PreferencesManager.shared
    
    var body: some View {
        ZStack {
            if self.preferencesManager.downloadedData {
                CitiesView()
            } else {
                SplashView()
            }
        }
    }
    
}
