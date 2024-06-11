//
//  ProductListInteractorStub.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListInteractorStub: ProductListInteractorType {
    
    var presenter: ProductListInteractorOuputType!
    var repository: SearchProductsRepositoryType
    var setErrorResult: Bool = false
    var error: ProductListError?
    
    init(repository: SearchProductsRepositoryType) {
        self.repository = repository
    }
    
    func searchProducts(query: String, countryId: String) {
        if setErrorResult {
            presenter.manageRequestError(error: error ?? .invalidResponse)
        } else {
            presenter.showResults(items: ProductInformationDummy.getProducts())
        }
    }
}
