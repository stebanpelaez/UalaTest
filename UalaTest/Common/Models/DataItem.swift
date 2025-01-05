//
//  DataItem.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

import Foundation
import SwiftData

/// Modelo de datos para almacenar en SwiftData
@Model
final class DataItem {
    
    var prefix: String
    var name: String
    var country: String
    var lat: Double
    var lon: Double
    var isBookmark: Bool
    
    init(prefix: String, name: String, country: String, lat: Double, lon: Double, isBookmark: Bool) {
        self.prefix = prefix
        self.name = name
        self.country = country
        self.lat = lat
        self.lon = lon
        self.isBookmark = isBookmark
    }
    
}
