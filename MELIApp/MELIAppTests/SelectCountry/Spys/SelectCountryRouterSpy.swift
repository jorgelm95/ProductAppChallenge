//
//  SelectCountryRouterSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import UIKit
@testable import MELIAppDomain
@testable import MELIApp

final class SelectCountryRouterSpy: SelectCountryRouterType {
    
    var viewControllerRef: UIViewController?
     enum Invocation: Int {
        case goToSearchProducts
    }
    
    var invocations: [Invocation] = []
    
    func goToSearchProducts(countryId: String) {
        invocations.append(.goToSearchProducts)
    }
}
