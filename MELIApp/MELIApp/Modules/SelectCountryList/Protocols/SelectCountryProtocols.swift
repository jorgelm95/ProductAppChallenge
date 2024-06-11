//
//  SelectCountryProtocols.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import UIKit
import MELIAppDomain

protocol SelectCountryInteractorType {
    var presenter: SelectCountryOuputPresenterType! { get set }
    var repository: CountriesRepositoryType { get set }
    func fetchCountries()
}

protocol SelectCountryPresenterType {
    func fetchCountries()
    func goToSearchProducts(idCountry: String)
}

protocol SelectCountryOuputPresenterType {
    func manageError(_ error: SelectCountryErrors)
    func showContries(_ countries: [Country])
}

protocol SelectCountryViewType: AnyObject {
    var presenter: SelectCountryPresenterType? { get set }
    var countries: [Country] { get set }
    
    func showErrorView(text: String)
    func removeLoadingView()
}

protocol SelectCountryRouterType {
    var viewControllerRef: UIViewController? { get set }
    func goToSearchProducts(countryId: String)
}
