//
//  ProductListRouterSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import UIKit
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListRouterSpy: ProductListRouterType {
    
    var viewControllerRef: UIViewController?
     enum Invocation: Int {
        case goToDetailProduct
    }
    
    var invocations: [Invocation] = []
    
    func goToDetailProductModule(_ product: ProductInformation) {
        invocations.append(.goToDetailProduct)
    }
}
