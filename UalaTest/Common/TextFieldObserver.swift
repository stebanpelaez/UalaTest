//
//  TextFieldObserver.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import SwiftUI
import Combine

/// Este observador se usa para reducir la cantidad de solicitudes y mejorar el rendimiento de la busqueda en tiempo de real
/// Tiene un retraso de 1 segundo despues de terminar de escribir y realizar la búsqueda, esto para no sobrecargar el sistema
class TextFieldObserver: ObservableObject {
    
    @Published var debouncedText = ""
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.$searchText
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newText in
                guard let self = self else { return }
                if newText != self.debouncedText {
                    self.debouncedText = newText
                }
            }
            .store(in: &self.cancellables)
    }
}
