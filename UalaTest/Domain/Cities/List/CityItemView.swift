//
//  CityItemView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//

import SwiftUI

struct CityItemView: View {
    
    @Bindable var dataItem: DataItem
    
    var body: some View {
        HStack {
            VStack {
                Text("\(dataItem.name), \(self.dataItem.country)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                Text("\(dataItem.lat), \(self.dataItem.lon)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            Button(action: {
                /// Modifico el item para que se marque como favorito o no, con SwiftData no requiero hacer ningun otro proceso ya que lo cambia en tiempo real en el modelo almacenado y queda auto guardado
                self.dataItem.isBookmark.toggle()
            }, label: {
                Image(systemName: self.dataItem.isBookmark ? "star.fill": "star")
                    .resizable()
                    .frame(width: 24, height: 24)
            })
        }
    }
    
}

#Preview {
    CityItemView(dataItem: MockHelper.mock)
        .padding()
}
