//
//  ServiceManagerMock.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
@testable import MELIAppData
@testable import MELIAppDomain
@testable import MELINetworking

final class ServiceManagerMock: ServiceManagerType {
    
    var isErrorExecution: Bool = false
    var errorExecution: ErrorHTTP.API = .undefined
    
    func execute<R>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API> where R : RequestType {
        
        if isErrorExecution {
            return Fail<R.Output, ErrorHTTP.API>(error: errorExecution).eraseToAnyPublisher()
        }
        
        return Future<R.Output, ErrorHTTP.API> { promise in
            promise(.success(
                ResponseResult<APISearchResponse>(
                    response: APISearchResponse(results:[APIProductInfo(
                        title: "Moto G 3 generacion",
                        condition: "Nuevo",
                        thumbnail: "",
                        price: 10.0,
                        seller: APISeller(nickname: "Mercado rapido"),
                        attributes: [APIAtrribute(id: "123", name: "marca", value: "Apple")],
                        acceptsMercadopago: false)]),
                    httpCode: 200)
                 as! R.Output)
          )}.eraseToAnyPublisher()
    }
    
    func handleDataTaskOutput(urlResponse: URLResponse, data: Data) throws -> (httpCode: Int, data: Data) {
        return (200, Data())
    }
}

final class ServiceManagerCountriesMock: ServiceManagerType {
    
    var isErrorExecution: Bool = false
    var errorExecution: ErrorHTTP.API = .undefined
    
    func execute<R>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API> where R : RequestType {
        
        if isErrorExecution {
            return Fail<R.Output, ErrorHTTP.API>(error: errorExecution).eraseToAnyPublisher()
        }
        
        return Future<R.Output, ErrorHTTP.API> { promise in
            promise(.success(
                ResponseResult<[APICountry]>(
                    response: [APICountry(id: "MLA", name: "Argentina"), APICountry(id: "MCO", name: "Colombia")],
                    httpCode: 200)
                 as! R.Output)
          )}.eraseToAnyPublisher()
    }
    
    func handleDataTaskOutput(urlResponse: URLResponse, data: Data) throws -> (httpCode: Int, data: Data) {
        return (200, Data())
    }
}
