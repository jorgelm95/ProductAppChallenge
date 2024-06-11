//
//  ProductInformationDummy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIAppDomain


struct ProductInformationDummy {
    
    static func getProduct() -> ProductInformation {
        return ProductInformation(
            title: "motorola g3",
            condition: "new",
            thumbnail: "",
            price: 2400.0,
            seller: Seller(nickName: "Mercado Libre Vendor"),
            attributes: [Atrribute(
                id: "1",
                name: "marca",
                value: "motorola")],
            accepts_mercadopago: true)
    }
    
    static func getProducts() -> [ProductInformation] {
        return [
            ProductInformation(
                title: "motorola g3",
                condition: "new",
                thumbnail: "",
                price: 2400.0,
                seller: Seller(nickName: "Mercado Libre Vendor"),
                attributes: [Atrribute(
                    id: "1",
                    name: "marca",
                    value: "motorola")],
                accepts_mercadopago: false),
            ProductInformation(
                title: "Iphone 14 Pro",
                condition: "new",
                thumbnail: "",
                price: 345000.0,
                seller: Seller(nickName: "Mercado Libre Vendor"),
                attributes: [Atrribute(
                    id: "1",
                    name: "marca",
                    value: "Apple")],
                accepts_mercadopago: false),
            ProductInformation(
                title: "Samnsung S24",
                condition: "new",
                thumbnail: "",
                price: 45677.0,
                seller: Seller(nickName: "Mercado Libre Vendor"),
                attributes: [Atrribute(
                    id: "1",
                    name: "marca",
                    value: "Samnsung")],
                accepts_mercadopago: false)
        ]
    }
}
