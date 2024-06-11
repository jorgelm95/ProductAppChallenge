//
//  ProductDetailPresenterTests.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import XCTest
@testable import MELIApp
@testable import MELIAppDomain

final class ProductDetailPresenterTests: XCTestCase {

    private var viewSpy: ProductDetailViewSpy!
    private var sut: ProductDetailPresenter!
    
    override func setUp() {
        super.setUp()
        viewSpy = ProductDetailViewSpy()
        sut = ProductDetailPresenter(view: viewSpy)
    }
    
    func test_viewDidLoad_WhenViewIsLoaded_then_SetPruductInformation() {
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertNotNil(viewSpy.product)
    }
}
