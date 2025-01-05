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

/// Este manager se usa para gestionar el acceso a `SwiftData`
class DataManager: DataManagerProtocol {
    
    private var queryCache: [String: [DataItem]] = [:] /// Se usa este diccionario para optimizar las busquedas y no acceder siempre a SwiftData
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = DataManager()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: DataItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = self.modelContainer.mainContext
    }
    
    init(modelContainer: ModelContainer, modelContext: ModelContext) {
        self.modelContainer = modelContainer
        self.modelContext = modelContext
    }
    
    /// Si el predicate es `nil` me trae todos los registros
    /// Siempre me trae ordenado los datos por nombre y pais
    private func getFetchDescriptor(_ predicate: Predicate<DataItem>?) -> FetchDescriptor<DataItem> {
        var request = FetchDescriptor<DataItem>(predicate: predicate, sortBy: [
            SortDescriptor(\.name, order: .forward),
            SortDescriptor(\.country, order: .forward)
        ])
        
        /// Se establece en máximo 500 registros para respuesta mas rápida y para no sobrecargar las vistas para busquedas especificas
        /// Esto limita el total de los resultados, pero lo considero una buena practica al realizar busquedas en tiempo real
        
        let limit = predicate == nil ? 3000 : 500   /// 3000 registros cuando muestre todo el listado
        
        request.fetchLimit = limit
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
    
    /// Buscar y devolver la lista de resultados, haciendo uso de `queryCache` para filtrar por busquedas recientes o accerder a swiftData
    /// - Parameter query: Texto a buscar, ya viene en minuscula
    /// - Returns: Lista de resultados desde cache o desde SwiftData
    func fetch(withSearch query: String) -> [DataItem] {
        
        /// Primero se busca en cache para optimizar las busquedas recientes
        if let cachedResults = self.queryCache[query] {
            print("Cache query='\(query)' : \(cachedResults.count)")
            return cachedResults
        }
        
        var predicate: Predicate<DataItem>? = nil
        if !query.isEmpty {
            predicate = #Predicate<DataItem> { city in
                city.prefix.contains(query)             /// Aca se realiza la validacion para filtrar los datos que coincidan
            }
        }
        
        let request = self.getFetchDescriptor(predicate)
        let newResults = self.runFetchRequest(request)
        
        print("SwiftData query='\(query)' : \(newResults.count)")
        self.queryCache[query] = newResults             /// Se guarda en cache el resultado de la busqueda
        
        return newResults
    }
    
    /// Me trae la lista de favoritos
    func fetchFavourites() -> [DataItem] {
        let predicate = #Predicate<DataItem> { city in
            city.isBookmark
        }
        let request = self.getFetchDescriptor(predicate)
        return self.runFetchRequest(request)
    }
    
    /// Esta funcion divide la informacion para almacenar en bloques de máximo 1000 registros para buenas practicas con SwiftData
    func add(_ items: [LocationItem]) {
        
        let batchSize = 1_000
        let totalItems = items.count
        
        do {
            for start in stride(from: 0, to: totalItems, by: batchSize) {
                let nextBlock = Swift.min(start + batchSize, totalItems)
                for i in start..<nextBlock {
                    let location = items[i]
                    /// Se usa este prefix para buscar en SwiftData ya se almacena en lowercased para una busqueda plana y que sea mas rapida
                    let prefix = "\(location.name.lowercased()), \(location.country.lowercased())"
                    let itemData = DataItem(prefix: prefix, name: location.name, country: location.country, lat: location.coord.lat, lon: location.coord.lon, isBookmark: false)
                    self.modelContext.insert(itemData)
                }
                try self.modelContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Elimina todo lo relacionado con el modelo y limpia cache
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
