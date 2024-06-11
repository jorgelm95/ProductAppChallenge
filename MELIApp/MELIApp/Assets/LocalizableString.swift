//
//  LocalizableString.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import Foundation

struct Strings {
    struct ProductList {
        static var searchBarPlaceholder: String { "ProductList.searchBarPlaceholder".localizable }
        static var emptyStateTitle: String { "ProductList.EmptyState.emptyTitle".localizable }
        static var emptyStateResultTitle: String { "ProductList.EmptyState.emptyResultTitle".localizable }
        static var emptyStateNetworkTitle: String { "ProductList.EmptyState.NetworkErrorTitle".localizable }
        static var productStateText: String { "ProductList.productStateText".localizable }
        
    }
    
    struct DetailProduct {
        static var titleScreen: String { "ProductDetail.titleScreen".localizable }
        static var SecondaryInformationHeadertitle: String { "ProductDetail.SecondaryInformationHeadertitle".localizable }
        static var buyNowButtonTitle: String { "ProductDeatil.primaryInformation.buyNowButtonTitle".localizable }
        static var addToCarButtonTitle: String { "ProductDeatil.primaryInformation.addToCarButtonTitle".localizable }
        static var quantityAvailableTitle: String { "ProductDeatil.primaryInformation.quantityAvailableTitle".localizable }
    }
    
    struct  SelectCountry {
        static var titleTable: String { "SelectCountry.titleTable".localizable }
    }
}
