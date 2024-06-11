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

// Struct for define the necesary properties for get products by a search query and countryId

struct SearchProductsRequest: RequestType {
    
    let query: String
    let countryId: String
    
    init(query: String, countryId: String) {
        self.query = query
        self.countryId = countryId
    }
    
    typealias Output = ResponseResult<APISearchResponse>
    
    var baseUrl: URL { URL(string: "https://api.mercadolibre.com/")! }
    var path: String { "sites/\(countryId)/search" }
    var queryParams: HTTPQueryParams {["q": query]}
    var method: HTTPMethod { .get }
    
    func decode(data: Data, httpCode: Int) throws -> ResponseResult<APISearchResponse> {
        let decoder = JSONDecoder()

        return Output(
            response: try decoder.decode(Output.Response.self, from: data),
            httpCode: httpCode)
    }
    
    
    private func printData(for data: Data) {
        guard let json = getJsonResponse(for: data) else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
    
    private func getJsonResponse(for data: Data) -> Dictionary<String, Any>? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
