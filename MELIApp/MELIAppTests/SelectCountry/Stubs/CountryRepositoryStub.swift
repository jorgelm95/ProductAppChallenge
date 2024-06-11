//
//  CountryRepositoryStub.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Combine
import MELIAppDomain

final class CountryRepositoryStub: CountriesRepositoryType {
    
    var setFailureResponse: Bool  = false
    
    func fetchCountries() -> AnyPublisher<[Country], SelectCountryErrors> {
        if setFailureResponse {
            return Fail<[Country], SelectCountryErrors>(error: .undefined).eraseToAnyPublisher()
        } else {
            return Future<[Country], SelectCountryErrors> { promise in
                promise(.success(CountryDummy.getCountries()))
            }.eraseToAnyPublisher()
        }
    }
}
