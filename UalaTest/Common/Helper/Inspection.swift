//
//  Inspection.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 4/01/25.
//

import Combine
import SwiftUI

/// Esta clase se usa para Test de UI con la libreria `ViewInspector` cuando tienen `@Environment`
internal final class Inspection<V> {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
