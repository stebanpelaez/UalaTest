//
//  Constants.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 5/01/25.
//
import Foundation

enum Constants {
    static let urlBase = "https://gist.githubusercontent.com/hernan-uala"
    static let endPointCities = "dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    
    static let downloadedData = "downloadedData"
    
    enum Messages {
        static let downloading = "Downloading cities..."
        
        static let placeholder = "Filter"
        static let notFovourites = "No favourites"
        static let notMatches = "No matches found"
    }
    
    enum Images {
        static let startFill = "star.fill"
        static let start = "star"
        
        static let magnifying = "magnifyingglass"
        static let xmark = "xmark.circle.fill"
    }
    
    enum Identifiers {
        static let mapDetail = "mapDetail"
        static let landscapeCities = "landscapeCities"
        static let favourites = "favourites"
    }
    
}
