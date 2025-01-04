//
//  CitiesListView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import SwiftUI


struct CitiesListView: View {
    
    @Environment(CitiesViewModel.self) private var viewModel
    
    @StateObject var textObserver = TextFieldObserver()
    @State private var showFavourites = false
    
    internal let inspection = Inspection<Self>()

    var body: some View {
        VStack {
            HStack {
                SearchBar(placeHolder: "Filter", searchText: $textObserver.searchText)
                    .padding(8)
                Button(action: {
                    self.showFavourites.toggle() /// Me muestra u oculta los favoritos
                    self.checkFetch()
                }) {
                    Image(systemName: self.showFavourites ? "star.fill": "star")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing)
                }
                .accessibilityIdentifier("favourites")
            }
            
            let items = self.viewModel.items
            
            if items.isEmpty {
                if self.showFavourites {
                    self.emptyListView("No favourites")
                } else if !self.textObserver.searchText.isEmpty {
                    self.emptyListView("No matches found")
                }
            }
            
            List {
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    Button(action: {
                        self.viewModel.selectedItem = item
                        self.viewModel.showDetail = true
                    }) {
                        CityItemView(dataItem: item)
                    }
                    .listRowBackground(index%2 == 0 ? Color.gray.opacity(0.15): Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onReceive(textObserver.$debouncedText) { _ in
            self.checkFetch()
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
    
    @ViewBuilder private func emptyListView(_ textEmpty: String) -> some View {
        Text(textEmpty)
            .font(.footnote)
    }
    
    /// Esta funcion se usa cuando se requiere mostrar los favoritos, o cuando hay un cambio en el texto ingresado en el buscador a traves de la funcion OnReceive
    private func checkFetch() {
        DispatchQueue.main.async {
            if self.showFavourites {
                self.viewModel.fetchFavourites()
            } else {
                self.viewModel.fetchCities(searchBy: self.textObserver.debouncedText)
            }
        }
    }
    
}

#Preview {
    CitiesListView()
        .environment(CitiesViewModel(dataManager: MockDataManager.shared))
}
