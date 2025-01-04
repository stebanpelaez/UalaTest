//
//  MockConstants.swift
//  vssh-ios-communicationTests
//
//  Created by Juan Esteban Peláez Martínez on 18/10/22.
//

import Foundation

@testable import UalaTest

enum ConstantsMock {
    
    static let apiBase = "https://www.apiTest.com/api-gateway"
    static let endPointCities = "cities/all"
    
    static let headers = [
        "cache-control": "no-cache, no-store, max-age=0, must-revalidate",
        "content-type": "application/json;charset=UTF-8",
        "date": "Tue, 18 Oct 2022 23:41:18 GMT",
        "expires": "0",
        "server": "Apache/2.4.18 (Ubuntu)",
        "Authorization": "12345",
        "strict-transport-security": "max-age=31536000; includeSubDomains; preload",
        "x-content-type-options": "nosniff",
        "x-frame-options": "DENY",
        "x-xss-protection": "1; mode=block"
    ]
    
    static let responseLocations = [
        [
            "country": "ES",
            "name": "Madrid",
            "_id": 600123,
            "coord": [
                "lat": 6.91231,
                "lon": 10.1231
            ] as [String: Any]
        ],
        [
            "country": "ES",
            "name": "Barcelona",
            "_id": 918231,
            "coord": [
                "lat": 12.91231,
                "lon": -21.12319
            ] as [String: Any]
        ]
    ]
    
}
