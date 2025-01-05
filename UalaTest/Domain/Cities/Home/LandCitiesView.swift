//
//  LandCitiesView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import SwiftUI

struct LandCitiesView: View {
    
    /// En esta posicion me muestra ambas vista de manera horizontal, aca no se usa Pila de navegación
    var body: some View {
        HStack {
            CitiesListView()
            DetailView()
                .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier(Constants.Identifiers.landscapeCities)
    }
    
}


#Preview {
    let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
    viewModel.selectedItem = MockHelper.mock
    return LandCitiesView().environment(viewModel)
}
