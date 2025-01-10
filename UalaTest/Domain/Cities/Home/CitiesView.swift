//
//  CitiesView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct CitiesView: View {

    /// Se modifica a geometry reader para saber mejor la orientacion del dispositivo
    @State private var viewModel: CitiesViewModel

    init(viewModel: CitiesViewModel? = nil) {
        self._viewModel = State(
            initialValue: viewModel
                ?? CitiesViewModel(dataManager: DataManager.shared))
    }
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if geometry.size.height > geometry.size.width {
                    PortCitiesView()
                } else {
                    LandCitiesView()
                }
            }
            .environment(self.viewModel)
        }
    }

}

#Preview {
    let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
    CitiesView(viewModel: viewModel)
}
