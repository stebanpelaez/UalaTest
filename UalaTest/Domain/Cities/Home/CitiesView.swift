//
//  CitiesView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct CitiesView: View {
    
    /// Esta variable se usa para saber en que orientacion  se encuentra el dispositivo
    /// El onReceive se activa cuando hay un cambio de orientacion del dispositivo para ajustar la vista
    @State var isPortrait: Bool = UIDevice.current.orientation.isPortrait
    
    @State private var viewModel : CitiesViewModel
    
    init(viewModel: CitiesViewModel? = nil) {
        self._viewModel = State(initialValue: viewModel ?? CitiesViewModel(dataManager: DataManager.shared))
    }
    
    var body: some View {
        Group {
            if self.isPortrait {
                PortCitiesView()
            } else {
                LandCitiesView()
            }
        }
        .environment(self.viewModel)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            self.isPortrait = UIDevice.current.orientation.isPortrait
        }
    }
    
}

#Preview {
    let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
    CitiesView(viewModel: viewModel)
}
