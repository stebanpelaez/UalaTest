//
//  DataItem.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

import Foundation
import SwiftData

@Model
final class DataItem {
    
    @Attribute(.unique) var cityId: String
    
    var name: String
    var country: String
    var lat: Double
    var lon: Double
    var isBookmark: Bool
    
    init(cityId: String, name: String, country: String, lat: Double, lon: Double, isBookmark: Bool) {
        self.cityId = cityId
        self.name = name
        self.country = country
        self.lat = lat
        self.lon = lon
        self.isBookmark = isBookmark
    }
    
}
