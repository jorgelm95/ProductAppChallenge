//
//  SelectCountryViewSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIAppDomain
@testable import MELIApp

final class SelectCountryViewSpy: SelectCountryViewType {
 
    enum Invocation: Int {
        case showError
        case removeLoadingView
    }
    
    var presenter: SelectCountryPresenterType?
    var countries: [Country] = []
    var invocations: [Invocation] = []
    
    func showErrorView(text: String) {
        invocations.append(.showError)
    }
    
    func removeLoadingView() {
        invocations.append(.removeLoadingView)
     }
}
