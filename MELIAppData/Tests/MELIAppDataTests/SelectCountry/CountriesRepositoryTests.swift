//
//  CountriesRepositoryTests.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import XCTest
@testable import MELIAppData
@testable import MELIAppDomain
@testable import MELINetworking

final class CountriesRepositoryTests: XCTestCase {
    
    private var serviceManager: ServiceManagerCountriesMock!
    private var adapter: CountryMapperAdapaterAble!
    private var sut: CountriesRepositoryType!
    
    override func setUp() {
        super.setUp()
        serviceManager = ServiceManagerCountriesMock()
        sut = CountriesRepository(
            serviceManager: serviceManager,
            mapperAdapater: CountryMapperAdapater())
    }
    
    override func tearDown() {
        super.tearDown()
        serviceManager = nil
        adapter = nil
        sut = nil
    }
    
    func test_fetchCountries_WhenGetCountries_then_resultIsGratherThanZero() {
        
        //Given
        let expectation = XCTestExpectation(description: "request for get countries")
        
        //When
        _ = sut.fetchCountries().sink { completion in
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
        let expectation = XCTestExpectation(description: "request for get countries with error")
        serviceManager.isErrorExecution = true
        serviceManager.errorExecution = .undefined
        
        //When
        _ = sut.fetchCountries().sink { completion in
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
