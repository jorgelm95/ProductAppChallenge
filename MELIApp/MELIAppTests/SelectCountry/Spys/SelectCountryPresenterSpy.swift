//
//  SelectCountryPresenterSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIAppDomain
@testable import MELIApp

final class SelectCountryPresenterSpy: SelectCountryOuputPresenterType {
    
    enum Invocation: Int {
        case showContries
        case manageError
    }
    
    var invoctations: [Invocation] = []
    
    func manageError(_ error: SelectCountryErrors) {
        invoctations.append(.manageError)
    }
    
    func showContries(_ countries: [Country]) {
        invoctations.append(.showContries)
    }
}
