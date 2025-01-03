//
//  APIService+Extension.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//
import Foundation

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(Int)
    case unexpectedResponse
    case errorBody
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .errorBody: return "Error in body"
        case .unknown: return "Unknown"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

enum HTTPHeader {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
    static let accept = "Accept"
    
    static let applicationJson = "application/json;charset=UTF-8"
    static let urlEncoded = "application/x-www-form-urlencoded"
}

enum Constants: String {
    case urlBase = "https://gist.githubusercontent.com/hernan-uala"
    case endPointCities = "dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    
    case downloadedData = "downloadedData"
}
