//
//  SearchBar.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

/// Se creo este componente y no se uso el `searchable` nativo de Swift porque me lo oculta en Landscape y siempre debe estar visible
struct SearchBar: View {
    
    let placeHolder: String
    @Binding var searchText: String
    
    var body: some View {
        let color = Color.black.opacity(0.8)
        HStack {
            Image(systemName: Constants.Images.magnifying)
            TextField(placeHolder, text: $searchText)
            if !self.searchText.isEmpty {
                Image(systemName:  Constants.Images.xmark)
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray2))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.searchText = ""
                        }
                    }
            }
        }
        .frame(height: 16.0)
        .foregroundColor(color)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(color)
        )
        .background(Color(.systemGray6).opacity(0.5))
    }
    
}

#Preview {
    @Previewable @State var text = ""
    return SearchBar(placeHolder: "Filtrar", searchText: $text).padding()
}

