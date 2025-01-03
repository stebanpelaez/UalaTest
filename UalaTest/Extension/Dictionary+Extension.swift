//
//  Dictionary+Extension.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

extension Dictionary {

    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            if let nKey = String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let nValue = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                parts.append("\(nKey)=\(nValue)")
            }
        }
        return parts.joined(separator: "&")
    }
}
