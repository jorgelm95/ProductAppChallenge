//
//  CountriesRepository.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//
import Foundation
import Combine
import MELIAppDomain
import MELINetworking

public class CountriesRepository: CountriesRepositoryType  {
    
    let serviceManager: ServiceManagerType
    let mapperAdapater: CountryMapperAdapaterAble
    
    public init(serviceManager: ServiceManagerType, mapperAdapater: CountryMapperAdapaterAble) {
            self.serviceManager = serviceManager
            self.mapperAdapater = mapperAdapater
    }
    
    public func fetchCountries() -> AnyPublisher<[Country], SelectCountryErrors> {
        let request = GetCountriesRequest()
        return serviceManager.execute(request)
            .map({ self.mapperAdapater.mapperCountry(apiData: $0.response) })
                   .mapError({ self.mapperError(error: $0) })
                   .eraseToAnyPublisher()
    }
    
    private func mapperError(error: ErrorHTTP.API) -> SelectCountryErrors {
        switch error {
        case .undefined:
            return .undefined
        default:
            return .undefined
        }
    }
}
