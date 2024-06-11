//
//  BaseRequest.swift
//  
//
//  Created by Jorge Menco on 7/06/24.
//

import Foundation
import Combine

public typealias HTTPHeaders = [String: Any]
public typealias HTTPQueryParams = [String: String]

// Enum for define the HTTP Errors that have the public API
public enum ErrorHTTP {
    
    public enum API: Error {
        case invalidResponse
        case undefined
    }
}

// Enum for define the diferents methods that allows  HTTP protocol
public enum HTTPMethod: String {
    case get = "GET"
}

// The requets protocol define a contract with properties and methods for create a http requets to the backend

public protocol RequestType {
    associatedtype Output
    var baseUrl: URL { get }
    var path: String { get }
    var queryParams: HTTPQueryParams { get }
    var method: HTTPMethod { get }
    func decode(data: Data, httpCode: Int) throws -> Output
}

extension RequestType {
    func buildRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: buildUrl())
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func buildUrl() -> URL {
        let url: URL = !path.isEmpty ? baseUrl.appendingPathComponent(path) : baseUrl
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return URL(fileURLWithPath: "")
        }
        
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.compactMap ({ URLQueryItem(name: $0.key, value: $0.value)})
        }
        return urlComponents.url ?? URL(fileURLWithPath: "")
    }
}
