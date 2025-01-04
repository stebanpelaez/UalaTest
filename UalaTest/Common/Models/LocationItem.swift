//
//  LocationItem.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import Foundation

/// Object que se usa para deserializar la data de las ciudades
struct LocationItem: Codable {
    let country, name: String
    let id: Int
    let coord: Coord

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}
