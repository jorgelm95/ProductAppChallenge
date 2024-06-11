//
//  SelectCountryInteractorStubs.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIApp
@testable import MELIAppDomain

final class SelectCountryInteractorStub: SelectCountryInteractorType {
    
    var presenter: SelectCountryOuputPresenterType!
    var repository: CountriesRepositoryType
    var setErrorResult: Bool = false
    
    init(repository: CountriesRepositoryType) {
        self.repository = repository
    }
    
    func fetchCountries() {
        if setErrorResult {
            presenter.manageError(.undefined)
         } else {
             presenter.showContries(CountryDummy.getCountries())
         }
    }
}
