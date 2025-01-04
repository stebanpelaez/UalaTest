//
//  MockHelper.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import Foundation

/// Mocks para las #Previews y pruebas unitarias
enum MockHelper {
    
    static let mock = DataItem(cityId: "", name: "Madrid", country: "ES", lat: 40.489349, lon: -3.68275, isBookmark: false)
    
    static let listDataItem = [
        DataItem(cityId: "id1", name: "City 1", country: "CO", lat: 40.0, lon: 12.0, isBookmark: false),
        DataItem(cityId: "id2", name: "City 2", country: "CO", lat: 10.0, lon: 12.0, isBookmark: false),
        DataItem(cityId: "id3", name: "City 3", country: "CO", lat: 10.0, lon: 12.0, isBookmark: true),
        DataItem(cityId: "id4", name: "City 4", country: "CO", lat: 10.0, lon: 12.0, isBookmark: false),
        DataItem(cityId: "id5", name: "City 5", country: "CO", lat: 10.0, lon: 12.0, isBookmark: false)
    ]
    
    static let listLocation = [
        LocationItem(country: "CO", name: "City 1", id: 123456, coord: Coord(lon: 40.0, lat: 12.0)),
        LocationItem(country: "CO", name: "City 2", id: 123457, coord: Coord(lon: 41.0, lat: 13.0)),
        LocationItem(country: "CO", name: "City 3", id: 123458, coord: Coord(lon: 42.0, lat: 14.0)),
        LocationItem(country: "CO", name: "prueba", id: 123459, coord: Coord(lon: 43.0, lat: 15.0)),
        LocationItem(country: "CO", name: "other", id: 123450, coord: Coord(lon: 44.0, lat: 16.0))
    ]
    
}
