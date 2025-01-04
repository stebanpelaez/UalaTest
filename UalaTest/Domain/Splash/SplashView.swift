//
//  SplashView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 1/01/25.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    
    private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel? = nil) {
        self.viewModel = viewModel ?? SplashViewModel(dataManager: DataManager.shared)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
            Text("Downloading cities...")
                .font(.title)
        }
        .task {
            self.viewModel.downloadData()
        }
    }
    
}

#Preview {
    
    let viewModel = SplashViewModel(apiManager: MockApiManager.shared, dataManager: MockDataManager.shared)
    
    return SplashView(viewModel: viewModel)
}
