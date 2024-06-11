//
//  SelectCountryInteractor.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class SelectCountryInteractorTests: XCTestCase {
    
    var presenterSpy: SelectCountryPresenterSpy!
    var repository: CountryRepositoryStub!
    var sut: SelectCountryInteractor!
    
    override func setUp() {
        super.setUp()
        presenterSpy = SelectCountryPresenterSpy()
        repository = CountryRepositoryStub()
        sut = SelectCountryInteractor(repository: repository)
        sut.presenter = presenterSpy
    }
    
    override func tearDown() {
         super.tearDown()
         presenterSpy = nil
         repository = nil
         sut = nil
     }
    
    func test_fetchCountries_whenfetchCountriesIsSuccess_ThenGetShowCountriesIsCalled() {
        
        //When
        sut.fetchCountries()
        
        //Then
        XCTAssertEqual(presenterSpy.invoctations, [.showContries])
    }
    
    func test_fetchCountries_whenfetchCountriesIsFailed_ThenManageErrorIsCalled() {
        //Given
        repository.setFailureResponse = true
        
        //When
        sut.fetchCountries()

        //Then
        XCTAssertEqual(presenterSpy.invoctations, [.manageError])
    }
}
