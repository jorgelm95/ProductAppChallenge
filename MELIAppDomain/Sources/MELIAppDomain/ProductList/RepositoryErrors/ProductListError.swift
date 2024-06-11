//
//  ProductListErros.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation

// Enum for manage the posible bussines errors presented in the operation for search products
public enum ProductListError: Error {
    case invalidResponse
    case undefined
}
