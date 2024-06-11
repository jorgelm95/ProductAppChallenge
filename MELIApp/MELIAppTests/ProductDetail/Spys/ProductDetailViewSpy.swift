//
//  ProductDetailViewSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation

@testable import MELIApp
@testable import MELIAppDomain

final class ProductDetailViewSpy: ProductDetailViewType {
    
    var presenter: ProductDetailPresenter?
    var product: ProductInformation
    
    init() {
        self.product = ProductInformationDummy.getProduct()
    }
}
