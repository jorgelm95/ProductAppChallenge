//
//  ProductListPresenterIntegrationTests.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListPresenterIntegrationTests: XCTestCase {
    
    private var repository: SearchProductsRepositoryStub!
    private var interactor: ProductListInteractorType!
    private var viewSpy: ProductListViewType!
    private var sut: ProductListPresenter!
    
    override func setUp() {
        super.setUp()
        repository = SearchProductsRepositoryStub()
        interactor = ProductListInteractor(repository: repository)
        viewSpy = ProductListViewController()
        sut = ProductListPresenter(
            interactor: interactor,
            view: viewSpy)
        interactor.presenter = sut
    }
    
    func test_searchProducts_WhenQueryIsValid_then_GetResults() {
        //Given
        let query = "celulares"
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.productListState, .filled)
        XCTAssertGreaterThan(viewSpy.items.count, 0)
    }

    func test_searchProducts_WhenQueryIsEmpty_then_GetEmptyResult() {
        //Given
        let query = ""
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.productListState, .emptyResults)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_searchProducts_WhenGetInvalidResponse_then_ListStateIsEptyResult() {
        //Given
        let query = "celulares"
        repository.setFailureResponse = true
        repository.error = .invalidResponse
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.productListState, .emptyResults)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_searchProducts_WhenGeTUndefineError_then_ListStateIsNetworkrError() {
        
        //Given
        let query = "celulares"
        repository.setFailureResponse = true
        repository.error = .undefined
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.productListState, .NetworkError)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
}
