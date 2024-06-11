//
//  CountryDummy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import MELIAppDomain

struct CountryDummy {
    static func getCountries() -> [Country] {
        return [Country(id: "MCO", name: "Colombia"),
                Country(id: "MLA", name: "Argentina")]
    }
}
