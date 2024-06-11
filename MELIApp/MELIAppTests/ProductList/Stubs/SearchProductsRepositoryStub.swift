//
//  SearchProductsRepositoryStub.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
@testable import MELIApp
@testable import MELIAppDomain

final class SearchProductsRepositoryStub: SearchProductsRepositoryType {

    var setFailureResponse: Bool  = false
    var error: ProductListError?
    
    func searchProducts(query: String, countryId: String) -> AnyPublisher<[ProductInformation], ProductListError> {
        
        if query.isEmpty {
            return Future<[ProductInformation], ProductListError> { promise in
                            promise(.success([]))
            }.eraseToAnyPublisher()
        }
        
        if setFailureResponse {
            return Fail<[ProductInformation], ProductListError>(error: error ?? .undefined).eraseToAnyPublisher()
        } else {
            return Future<[ProductInformation], ProductListError> { promise in
                promise(.success(ProductInformationDummy.getProducts()))
            }.eraseToAnyPublisher()
        }
    }
}
