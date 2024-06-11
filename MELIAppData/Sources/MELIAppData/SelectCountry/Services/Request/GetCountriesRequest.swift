//
//  GetCountriesRequest.swift
//  
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import MELINetworking

struct GetCountriesRequest: RequestType {
    
    typealias Output = ResponseResult<[APICountry]>
    
    var baseUrl: URL { URL(string: "https://api.mercadolibre.com/")! }
    var path: String { "sites" }
    var queryParams: HTTPQueryParams {[:]}
    var method: HTTPMethod { .get }
    
    func decode(data: Data, httpCode: Int) throws -> Output {
        let decoder = JSONDecoder()
        return Output(
            response: try decoder.decode(Output.Response.self, from: data),
            httpCode: httpCode)
    }
    

}
