//
//  CountriesRepositoryType.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine

public protocol CountriesRepositoryType {
    func fetchCountries() -> AnyPublisher<[Country], SelectCountryErrors>
}
