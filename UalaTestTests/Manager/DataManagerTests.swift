//
//  DataManagerTests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import XCTest
import SwiftData

@testable import UalaTest

final class DataManagerTests: XCTestCase {
    
    @MainActor
    func testDataManager() {
                
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try! ModelContainer(for: DataItem.self, configurations: configuration)

        let manager = DataManager(modelContainer: modelContainer, modelContext: modelContainer.mainContext)
        
        manager.add(MockHelper.listLocation)
        
        let all = manager.fetch(withSearch: "").count
        XCTAssertEqual(all, 5)
        
        let item = manager.fetch(withSearch: "prueba").first
        _ = manager.fetch(withSearch: "prueba")
        XCTAssertNotNil(item)
        
        item?.isBookmark.toggle()
                        
        let favourites = manager.fetchFavourites().count
        XCTAssertEqual(favourites, 1)
        
        manager.removeAll()
        
        let all2 = manager.fetch(withSearch: "").count
        XCTAssertEqual(all2, 0)
    }
    
}
