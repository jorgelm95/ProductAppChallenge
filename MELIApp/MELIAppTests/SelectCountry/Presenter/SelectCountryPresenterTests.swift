//
//  SelectCountryPresenterTests.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class SelectCountryPresenterTests: XCTestCase {
    
    private var interactor: SelectCountryInteractorStub!
    private var viewSpy: SelectCountryViewSpy!
    private var routerSpy: SelectCountryRouterSpy!
    private var sut: SelectCountryPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = SelectCountryInteractorStub(repository: CountryRepositoryStub())
        viewSpy = SelectCountryViewSpy()
        routerSpy = SelectCountryRouterSpy()
        sut = SelectCountryPresenter(
            interactor: interactor,
            view: viewSpy)
        sut.router = routerSpy
        interactor.presenter = sut
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        viewSpy = nil
        routerSpy = nil
        sut = nil
    }
    
    func test_fetchCountries_WhenFetchCountriesIssuccess_then_FilledCountries() {
        
        //When
        sut.fetchCountries()
        
        //Then
        XCTAssertEqual(viewSpy.invocations, [.removeLoadingView])
        XCTAssertGreaterThan(viewSpy.countries.count, 0)
    }
    
    func test_fetchCountries_WhenFetchCountriesIsFailed_then_removeLoadingViewIsCalled() {
        
        //Given
        interactor.setErrorResult = true
        
        //When
        sut.fetchCountries()
        
        //Then
        XCTAssertEqual(viewSpy.invocations, [.removeLoadingView, .showError])
    }
    
    func test_gotoSearchProducts_WhenSelectAnyCountry_then_goToSearchProductsScreen() {
        
        //When
        sut.goToSearchProducts(idCountry: "MLA")
        
        //Then
        XCTAssertEqual(routerSpy.invocations, [.goToSearchProducts])
    }
}
