//
//  ProductListProtocols.swift
//  MELIApp
//
//  Created by Jorge Menco on 8/06/24.
//

import UIKit
import Foundation
import Combine
import MELIAppDomain

protocol ProductListInteractorType: AnyObject {
    var presenter: ProductListInteractorOuputType? { get set }
    var repository: SearchProductsRepositoryType { get set }
    func searchProducts(query: String, countryId: String)
}

protocol ProductListInteractorOuputType: AnyObject {
    func showResults(items: [ProductInformation])
    func manageRequestError(error: ProductListError)
}

protocol ProductListPresenterType: AnyObject {
    var interactor: ProductListInteractorType { get set }
    var view: ProductListViewType { get set }
    var router: ProductListRouterType? { get set }
    var countryId: String { get set }
    
    func searchProducts(query: String)
    func goToProductDeatil(_ product: ProductInformation)
}

protocol ProductListViewType: AnyObject {
    var presenter: ProductListPresenterType? { get set }
    var items: [ProductInformation] { get set }
    var productListState: ProductListState { get set }
    
    func removeLoadingView()
}

protocol ProductListRouterType: AnyObject {
    var viewControllerRef: UIViewController? { get set }
    func goToDetailProductModule(_ product: ProductInformation)
}

enum ProductListState {
    case initialEmpty
    case searchring
    case filled
    case emptyResults
    case NetworkError
}
