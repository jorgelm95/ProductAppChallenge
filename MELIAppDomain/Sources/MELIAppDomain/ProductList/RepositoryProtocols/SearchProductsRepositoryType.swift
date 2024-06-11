//
//  SearchProductsRepositoryType.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine

public protocol SearchProductsRepositoryType: AnyObject {
    func searchProducts(query: String, countryId: String) -> AnyPublisher<[ProductInformation], ProductListError>
}

public struct Country: Comparable {
    
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public static func < (lhs: Country, rhs: Country) -> Bool {
         lhs.id == rhs.id &&
         lhs.name == rhs.name
     }
}
