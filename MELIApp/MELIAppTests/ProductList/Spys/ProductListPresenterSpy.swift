//
//  ProductListPresenterSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListPresenterSpy: ProductListInteractorOuputType {
    
    enum Invocation: Int {
        case showResults
        case manageError
    }
    
    var invoctations: [Invocation] = []
    var itemsResult: [ProductInformation] = []
    
    func showResults(items: [ProductInformation]) {
        itemsResult = items
        invoctations.append(.showResults)
    }
    
    func manageRequestError(error: ProductListError) {
        invoctations.append(.manageError)
    }
}
