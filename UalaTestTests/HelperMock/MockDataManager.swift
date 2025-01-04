//
//  MockDataManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

@testable import UalaTest

class MockDataManager: DataManagerProtocol {
    
    static let shared = MockDataManager()
    
    func fetch(withSearch search: String) -> [DataItem] {
        MockHelper.listDataItem
    }
    
    func fetchFavourites() -> [DataItem] {
        MockHelper.listDataItem.filter { $0.isBookmark }
    }
    
    func add(_ items: [LocationItem]) {
        
    }
    
    func removeAll() {
        
    }
    
}
