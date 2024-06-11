//
//  File.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine
import MELIAppDomain
import MELINetworking

final public class SearchProductsRepository: SearchProductsRepositoryType {
    
    let serviceManager: ServiceManagerType
    let productMapperAdapter: ProductMapperAdapaterAble
    
    public init(
        serviceManager: ServiceManagerType,
        mapperAdapater: ProductMapperAdapaterAble) {
            self.serviceManager = serviceManager
            self.productMapperAdapter = mapperAdapater
    }
    
    public func searchProducts(query: String, countryId: String) -> AnyPublisher<[ProductInformation], ProductListError> {
        
        let request = SearchProductsRequest(query: query, countryId: countryId)
        
        return serviceManager.execute(request)
            .map({ self.productMapperAdapter.mapProductsToDomainModel(apiData: $0.response.results) })
            .mapError({ self.mapperError(error: $0) })
            .eraseToAnyPublisher()
    }
    
    private func mapperError(error: ErrorHTTP.API) -> ProductListError {
        switch error {
        case .invalidResponse:
            return .invalidResponse
        case .undefined:
            return .undefined
        }
    }
}
