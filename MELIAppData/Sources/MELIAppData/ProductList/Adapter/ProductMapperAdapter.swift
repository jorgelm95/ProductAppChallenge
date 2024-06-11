//
//  ProductMapperAdapter.swift
//  
//
//  Created by Jorge Menco on 9/06/24.
//

import Foundation
import MELIAppDomain

// Class designe for map the APImodels to Domain models and viceversa 

public protocol ProductMapperAdapaterAble {
    func mapProductsToDomainModel(apiData: [APIProductInfo]) -> [ProductInformation]
    func mapSellerToDomainModel(apiSeller: APISeller) -> Seller
    func mapAttributesToDomainModel(apiAttributes: [APIAtrribute]) -> [Atrribute]
}

public final class ProductMapperAdapter: ProductMapperAdapaterAble {
    
    public init() {}
    
    public func mapProductsToDomainModel(apiData: [APIProductInfo]) -> [ProductInformation] {
        let result = apiData.compactMap { product in
            ProductInformation(
                title: product.title,
                condition: product.condition ?? "",
                thumbnail: product.thumbnail,
                price: product.price,
                seller: self.mapSellerToDomainModel(apiSeller: product.seller ?? APISeller(nickname: "")),
                attributes: self.mapAttributesToDomainModel(apiAttributes: product.attributes ?? []),
                accepts_mercadopago: product.acceptsMercadopago ?? false)
        }
        
        return result
    }
    
    public func mapSellerToDomainModel(apiSeller: APISeller) -> Seller {
        return Seller(nickName: apiSeller.nickname ?? "")
    }
    
    public func mapAttributesToDomainModel(apiAttributes: [APIAtrribute]) -> [Atrribute] {
        if apiAttributes.isEmpty {
            return []
        }
        
        return apiAttributes.compactMap { attribute in
            Atrribute(id: attribute.id, name: attribute.name, value: attribute.value)
        }
    }
}
