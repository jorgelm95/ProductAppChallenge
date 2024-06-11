//
//  SelectCountryRouter.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import UIKit
import MELINetworking
import MELIAppDomain
import MELIAppData

class SelecCountryRouter: SelectCountryRouterType {
    
    
    var viewControllerRef: UIViewController?
    
    static func buildModule() -> SelectCountryViewController {
        
        let repository: CountriesRepositoryType = CountriesRepository(
            serviceManager: ServiceManager(),
            mapperAdapater: CountryMapperAdapater())
        let interactor: SelectCountryInteractorType = SelectCountryInteractor(
            repository: repository)
        let view = SelectCountryViewController()
        let presenter = SelectCountryPresenter(interactor: interactor, view: view)
        let router = SelecCountryRouter()
        view.presenter = presenter
        router.viewControllerRef = view
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func goToSearchProducts(countryId: String) {
        guard let navigationController = viewControllerRef?.navigationController else { return }
        let viewController = ProductListRouter.buildModule(countryId: countryId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
