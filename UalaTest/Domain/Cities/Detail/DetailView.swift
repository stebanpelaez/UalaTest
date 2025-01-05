//
//  DetailView.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 2/01/25.
//
import SwiftUI
import MapKit

struct DetailView: View {
    
    @Environment(CitiesViewModel.self) private var viewModel
    
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        if let item = self.viewModel.selectedItem {
            let name = "\(item.name), \(item.country)"
            let coordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)
            let rect = MKMapRect(origin: MKMapPoint(coordinate),
                                 size: MKMapSize(width: 1, height: 1))
            
            Map(bounds: MapCameraBounds(centerCoordinateBounds: rect,
                                        minimumDistance: 10000,
                                        maximumDistance: 20000)) {
                Marker(item.name, coordinate: coordinate)
            }
            .accessibilityIdentifier(Constants.Identifiers.mapDetail)
            .navigationTitle(name)
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        }
    }
    
}


#Preview {
    
    let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
    viewModel.selectedItem = MockHelper.mock
    
    return DetailView().environment(viewModel)
}

