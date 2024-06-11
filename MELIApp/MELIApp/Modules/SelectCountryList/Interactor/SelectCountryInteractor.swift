//
//  SelectCountryInteractor.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import Foundation
import Combine
import MELIAppDomain

final class SelectCountryInteractor: SelectCountryInteractorType {
    
    // MARK: - Private properties -
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Internal properties -
    
    var presenter: SelectCountryOuputPresenterType!
    var repository: CountriesRepositoryType
    
    // MARK: - LifeCycle -
    
    init(repository: CountriesRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal methods -
    
    func fetchCountries() {
        return repository.fetchCountries().sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.presenter.manageError(error)
            }
        } receiveValue: { [weak self] result in
            guard let self else { return }
            self.presenter.showContries(result)
        }.store(in: &cancellable)
    }
}
