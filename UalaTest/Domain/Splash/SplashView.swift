//
//  SplashView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 1/01/25.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2.0, anchor: .center)
        
    }
    
}


#Preview {
    SplashView()
}
