//
//  MockDataManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import Foundation

/// Mocks para las #Previews y pruebas unitarias
class MockDataManager: DataManagerProtocol {
    
    static let shared = MockDataManager()
    
    func fetch(withSearch search: String) -> [DataItem] {
        let items = MockHelper.listDataItem
        if search.isEmpty {
            return items
        } else {
            return items.filter { $0.name.lowercased().contains(search.lowercased())}
        }
    }
    
    func fetchFavourites() -> [DataItem] {
        MockHelper.listDataItem.filter { $0.isBookmark }
    }
    
    func add(_ items: [LocationItem]) {
        
    }
    
    func removeAll() {
        
    }
    
}
