//
//  CountryMapperAdapater.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import MELIAppDomain

public protocol CountryMapperAdapaterAble {
    func mapperCountry(apiData: [APICountry]) -> [Country]
}

public final class CountryMapperAdapater: CountryMapperAdapaterAble {
    
    public init() {}
    
    public func mapperCountry(apiData: [APICountry]) -> [Country] {
        let result = apiData.compactMap { apiCountry in
            Country(id: apiCountry.id, name: apiCountry.name)
        }
        
        return result
    }
}
