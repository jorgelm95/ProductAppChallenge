//
//  ProductListViewSpy.swift
//  MELIAppTests
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
@testable import MELIApp
@testable import MELIAppDomain

final class ProductListViewSpy: ProductListViewType {
    
    enum Invocation: Int {
        case removeLoadingView
    }
    
    var presenter: ProductListPresenterType?
    var items: [ProductInformation] = []
    var productListState: ProductListState = .initialEmpty
    var invoctations: [Invocation] = []
    
    func removeLoadingView() {
        invoctations.append(.removeLoadingView)
    }
}
