//
//  URL+Extension.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 31/12/24.
//

import Foundation

extension URL {
    
    internal static func concatenateUrl(_ initialPath: String?, finalPath: String?) -> String? {
        
        let initialPath = initialPath ?? ""
        let finalPath = finalPath ?? ""
        var isSeparatorInitial = false
        var isSeparatorFinal = false
        var path: String?
        
        if !initialPath.isEmpty {
            isSeparatorInitial = initialPath.last == "/"
        } else {
            return finalPath
        }
        
        if !finalPath.isEmpty {
            isSeparatorFinal = finalPath.first == "/"
        } else {
            return initialPath
        }
        
        if isSeparatorFinal && isSeparatorInitial {
            let initialAux = (initialPath as NSString?)?.substring(to: initialPath.count - 1) ?? ""
            path = "\(initialAux)\(finalPath)"
        } else if ((!isSeparatorInitial) && isSeparatorFinal) || (isSeparatorInitial && !isSeparatorFinal) {
            path = "\(initialPath)\(finalPath)"
        } else {
            path = "\(initialPath)/\(finalPath)"
        }
        
        return path
    }
    
}
