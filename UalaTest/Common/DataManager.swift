//
//  DataManager.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 1/01/25.
//
import Foundation
import SwiftData

protocol DataManagerProtocol: AnyObject {
    func fetch(withSearch search: String) -> [DataItem]
    func fetchFavourites() -> [DataItem]
    func add(_ items: [LocationItem])
    func removeAll()
}

class DataManager: DataManagerProtocol {
    
    private var queryCache: [String: [DataItem]] = [:]
    
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = DataManager()
    
    @MainActor
    init(memoryOnly: Bool = false) {
        let modelContainer = try! ModelContainer(for: DataItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: memoryOnly))
        self.modelContext = modelContainer.mainContext
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    private func getFetchDescriptor(_ predicate: Predicate<DataItem>?) -> FetchDescriptor<DataItem> {
        var request = FetchDescriptor<DataItem>(predicate: predicate, sortBy: [
            SortDescriptor(\.name, order: .forward),
            SortDescriptor(\.country, order: .forward)
        ])
        request.fetchLimit = 500
        return request
    }
    
    private func runFetchRequest(_ request: FetchDescriptor<DataItem>) ->  [DataItem] {
        do {
            return try self.modelContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetch(withSearch query: String) -> [DataItem] {
        
        if let cachedResults = self.queryCache[query] {
            print("Cache", query, cachedResults.count)
            return cachedResults
        }
        
        var predicate: Predicate<DataItem>? = nil
        if !query.isEmpty {
            predicate = #Predicate<DataItem> { city in
                city.cityId.contains(query)
            }
        }
        
        let request = self.getFetchDescriptor(predicate)
        let newResults = self.runFetchRequest(request)
        
        print("SwiftData", query, newResults.count)
        self.queryCache[query] = newResults
        
        return newResults
    }
    
    func fetchFavourites() -> [DataItem] {
        let predicate = #Predicate<DataItem> { city in
            city.isBookmark
        }
        let request = self.getFetchDescriptor(predicate)
        return self.runFetchRequest(request)
    }
    
    func add(_ items: [LocationItem]) {
        
        let batchSize = 1_000
        let totalItems = items.count
        
        do {
            for start in stride(from: 0, to: totalItems, by: batchSize) {
                let nextBlock = Swift.min(start + batchSize, totalItems)
                for i in start..<nextBlock {
                    let location = items[i]
                    let key = "\(location.name.lowercased()), \(location.country.lowercased())"
                    let itemData = DataItem(cityId: key, name: location.name, country: location.country, lat: location.coord.lat, lon: location.coord.lon, isBookmark: false)
                    self.modelContext.insert(itemData)
                }
                try self.modelContext.save()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeAll() {
        do {
            self.queryCache.removeAll()
            try self.modelContext.delete(model: DataItem.self)
            try self.modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
