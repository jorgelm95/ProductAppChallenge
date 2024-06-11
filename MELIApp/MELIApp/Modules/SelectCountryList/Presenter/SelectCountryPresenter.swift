//
//  SelectCountryPresenter.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import MELIAppDomain

class SelectCountryPresenter: SelectCountryPresenterType {
    
    // MARK: - Internal properties -
    
    var interactor: SelectCountryInteractorType
    var router: SelectCountryRouterType?
    unowned var view: SelectCountryViewType
    
    // MARK: - LifeCycle -
    
    init(interactor: SelectCountryInteractorType, view: SelectCountryViewType) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Internal methods -
    
    func fetchCountries() {
        interactor.fetchCountries()
    }
    
    func goToSearchProducts(idCountry: String) {
        router?.goToSearchProducts(countryId: idCountry)
    }
}

extension SelectCountryPresenter: SelectCountryOuputPresenterType {
    func manageError(_ error: SelectCountryErrors) {
        view.removeLoadingView()
        view.showErrorView(text: "ocurrio un error de red intenta de nuevo")
    }
    
    func showContries(_ countries: [Country]) {
        view.removeLoadingView()
        view.countries = countries.sorted(by: { $0.name < $1.name })
    }
}
