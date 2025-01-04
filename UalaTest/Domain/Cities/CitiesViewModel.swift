//
//  CitiesViewModel.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI
import Combine

@Observable
class CitiesViewModel {
    
    var items: [DataItem] = []
    var selectedItem: DataItem? = nil
    var showDetail: Bool = false
        
    @ObservationIgnored
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func fetchCities(searchBy search: String) {
        let cleanSearch = search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        self.items = self.dataManager.fetch(withSearch: cleanSearch)
    }
    
    func fetchFavourites() {
        self.items = self.dataManager.fetchFavourites()
    }
    
}
