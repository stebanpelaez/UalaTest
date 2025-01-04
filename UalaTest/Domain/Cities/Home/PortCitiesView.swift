//
//  PortCitiesView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct PortCitiesView: View {
    
    @Environment(CitiesViewModel.self) private var viewModel
    
    /// En esta posicion, se embebe en un NavigationStack para cuando le de tap a un item me lleve a una nueva vista dentro de la pila de navegación
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            CitiesListView()
                .navigationDestination(isPresented: $viewModel.showDetail) {
                    DetailView()
                }
        }
    }
    
}


#Preview {
    let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
    PortCitiesView().environment(viewModel)
}
