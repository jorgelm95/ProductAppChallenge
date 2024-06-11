//
//  ServiceManagerMock.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import XCTest
@testable import MELIAppData
@testable import MELIAppDomain
@testable import MELINetworking

final class SearchProductsRepositoryTests: XCTestCase {
    
    private var serviceManager: ServiceManagerMock!
    private var adapter: ProductMapperAdapaterAble!
    private var sut: SearchProductsRepositoryType!
    
    override func setUp() {
        super.setUp()
        serviceManager = ServiceManagerMock()
        sut = SearchProductsRepository(serviceManager: serviceManager, mapperAdapater: ProductMapperAdapter())
    }
    
    override func tearDown() {
        super.tearDown()
        serviceManager = nil
        adapter = nil
        sut = nil
    }
    
    func test_searchProducts_WhenQueryIsValid_then_GetResults() {
        //Given
        let countriId: String = "MCO"
        let query: String = "celulares"
        let expectation = XCTestExpectation(description: "request for get products")
        
        //When
        _ = sut.searchProducts(query: query, countryId: countriId).sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        } receiveValue: { result in
            //Then
            XCTAssertGreaterThan(result.count, 0)
        }
        
        wait(for: [expectation])
    }
    
    func test_searchProducts_WhenGotErrorInExecution_then_Success() {
        
        //Given
        let countriId: String = "MCO"
        let query = "celulares"
        let expectation = XCTestExpectation(description: "request for get products with error")
        serviceManager.isErrorExecution = true
        serviceManager.errorExecution = .invalidResponse
        //When
        _ = sut.searchProducts(query: query, countryId: countriId).sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
                break
            case .failure(let error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        } receiveValue: { result in
            //Then
            XCTFail()
        }
        
        wait(for: [expectation])
    }
}
