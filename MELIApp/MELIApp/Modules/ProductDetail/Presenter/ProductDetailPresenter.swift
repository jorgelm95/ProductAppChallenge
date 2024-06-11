//
//  ProductDetailPresenter.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import Foundation
import MELIAppDomain

final class ProductDetailPresenter: ProductDetailPresenterType {
    
    unowned var view: ProductDetailViewType
    var product: ProductInformation?
    
    init(view: ProductDetailViewType) {
        self.view = view
    }
    
    func viewDidLoad() {
        guard let product else { return }
        view.product = product
    }
}
