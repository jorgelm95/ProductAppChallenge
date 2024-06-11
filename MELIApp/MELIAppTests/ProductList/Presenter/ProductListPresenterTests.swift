//
//  ProductListPresenterTests.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListPresenterTests: XCTestCase {
    
    private var interactor: ProductListInteractorStub!
    private var viewSpy: ProductListViewSpy!
    private var routerSpy: ProductListRouterSpy!
    private var sut: ProductListPresenter!
    
    override func setUp() {
        super.setUp()
        interactor = ProductListInteractorStub(repository: SearchProductsRepositoryStub())
        viewSpy = ProductListViewSpy()
        routerSpy = ProductListRouterSpy()
        sut = ProductListPresenter(
            interactor: interactor,
            view: viewSpy)
        sut.router = routerSpy
        interactor.presenter = sut
    }
    
    func test_searchProducts_WhenQueryIsValid_then_GetResults() {
        //Given
        let query = "celulares"
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.productListState, .filled)
        XCTAssertGreaterThan(viewSpy.items.count, 0)
    }
    
    func test_searchProducts_WhenGetInvalidResponseError_then_ListStateIsEptyResult() {
        //Given
        let query = "celulares"
        interactor.setErrorResult = true
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.productListState, .emptyResults)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_searchProducts_WhenGeTUndefineError_then_ListStateIsNetworkrError() {
        
        //Given
        let query = "celulares"
        interactor.setErrorResult = true
        interactor.error = .undefined
        
        //When
        sut.searchProducts(query: query)
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.productListState, .NetworkError)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_goToProductDeatil_TapInAnyProduct_then_SentUserToDetailProduct() {
        
        //Given
        let product = ProductInformationDummy.getProduct()
        
        //When
        sut.goToProductDeatil(product)
        
        //Then
        XCTAssertEqual(routerSpy.invocations, [.goToDetailProduct])
    }
}
