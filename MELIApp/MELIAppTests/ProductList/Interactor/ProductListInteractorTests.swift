//
//  ProductListInteractorTests.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListInteractorTests: XCTestCase {
    
    var presenterSpy: ProductListPresenterSpy!
    var repository: SearchProductsRepositoryStub!
    var sut: ProductListInteractor!
    
    override func setUp() {
        super.setUp()
        presenterSpy = ProductListPresenterSpy()
        repository = SearchProductsRepositoryStub()
        sut = ProductListInteractor(repository: repository)
        sut.presenter = presenterSpy
    }
    
    func test_searchProducts_whenQueryIsNotEmpty_ThenGetShowResults() {
        //Given
        let query = "celulares"
        let countryId = "MCO"
        
        //When
        sut.searchProducts(query: query, countryId: countryId)
        
        //Then
        XCTAssertEqual(presenterSpy.invoctations, [.showResults])
    }
    
    func test_searchProducts_whenGotAError_ThenManageErrorIscalled() {
        //Given
        let query = "celulares"
        let countryID = "MCO"
        repository.setFailureResponse = true
        
        //When
        sut.searchProducts(query: query, countryId: countryID)
        
        //Then
        XCTAssertEqual(presenterSpy.invoctations, [.manageError])
    }
}
