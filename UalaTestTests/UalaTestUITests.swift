//
//  UalaTestUITests.swift
//  UalaTest
//
//  Created by Juan Esteban Pelaez on 3/01/25.
//

import XCTest
import ViewInspector
import SwiftUI

@testable import UalaTest

extension Inspection: InspectionEmissary { }

final class UalaTestUITests: XCTestCase {
    
    func testSplashView() throws {
        
        PreferencesManager.shared.downloadedData = true
        
        let sut = SplashView(viewModel: SplashViewModel(apiManager: MockApiManager.shared, dataManager: MockDataManager.shared))
        
        let value = try sut.inspect().implicitAnyView().vStack().text(1).string()
        XCTAssertEqual(value, Constants.Messages.downloading)
    }
    
    func testContentView() throws {
        
        PreferencesManager.shared.downloadedData = false
        
        let sut = ContentView()
        
        let sutSplash = try sut.inspect().find(SplashView.self).actualView()
        let valueSplash = try sutSplash.inspect().implicitAnyView().vStack().text(1).string()
        XCTAssertEqual(valueSplash, Constants.Messages.downloading)
        
        PreferencesManager.shared.downloadedData = true
        
        let citiesView = try sut.inspect().find(CitiesView.self).actualView()
        let value = citiesView.isPortrait
        XCTAssertEqual(value, true)
    }
    
    func testLandCitiesView() throws {
        let sut = LandCitiesView()
        let value = try sut.inspect().implicitAnyView().hStack().accessibilityIdentifier()
        XCTAssertEqual(value, Constants.Identifiers.landscapeCities)
    }
    
    func testSearchBar() throws {
        let search = Binding<String>(wrappedValue: "Hola")
    
        let sut = SearchBar(placeHolder: Constants.Messages.placeholder, searchText: search)
        try sut.inspect().implicitAnyView().hStack().image(2).callOnTapGesture()
        
        XCTAssertTrue(search.wrappedValue.isEmpty)
    }
    
    @MainActor
    func testCitiesListView() throws {
        
        let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
        
        let sut = CitiesListView()
        _ = sut.environment(viewModel)
        
        let exp = sut.inspection.inspect { view in
            let button = try view.implicitAnyView().vStack().hStack(0).button(1)
            try button.tap()
            XCTAssertEqual(try button.accessibilityIdentifier(), Constants.Identifiers.favourites)
        }
        
        ViewHosting.host(view: sut.environment(viewModel))
        defer { ViewHosting.expel() }
        wait(for: [exp], timeout: 1.0)
    }

    @MainActor
    func testDetailView() throws {
        
        let viewModel = CitiesViewModel(dataManager: MockDataManager.shared)
        viewModel.selectedItem = MockHelper.mock
        
        let sut = DetailView()
        
        let exp = sut.inspection.inspect { view in
            let value = try view.implicitAnyView().map().accessibilityIdentifier()
            XCTAssertEqual(value, Constants.Identifiers.mapDetail)
        }
                
        ViewHosting.host(view: sut.environment(viewModel))
        defer { ViewHosting.expel() }
        wait(for: [exp], timeout: 1.0)
    }
    
}
