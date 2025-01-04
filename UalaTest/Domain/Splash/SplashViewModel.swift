//
//  SplashViewModel.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 1/01/25.
//

import SwiftUI
import Combine

class SplashViewModel {
        
    private var cancellables = Set<AnyCancellable>()
    
    private let apiManager: APIManagerProtocol
    private let dataManager: DataManagerProtocol
    private let preferencesManager = PreferencesManager.shared
        
    init(apiManager: APIManagerProtocol = APIManager.shared, dataManager: DataManagerProtocol) {
        self.apiManager = apiManager
        self.dataManager = dataManager
    }
    
    func downloadData() {
        
        if self.preferencesManager.downloadedData {
            self.loadDataInStorage()
            return
        }
        
        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withEndPoint(Constants.endPointCities.rawValue)
            .withMethod(.get)
            .build()
        
        self.apiManager.fetchData(request: request, type: [LocationItem].self)
            .sink {
                if case .failure(let error) = $0 {
                    print(error)
                }
            } receiveValue: { [weak self] locations in
                self?.saveDataInStorage(locations: locations)
            }.store(in: &self.cancellables)
    }
    
    private func saveDataInStorage(locations: [LocationItem]) {
        self.loadDataInStorage()
    }
    
    private func loadDataInStorage()  {
        self.preferencesManager.downloadedData = true
    }
    
}
