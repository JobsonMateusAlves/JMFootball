//
//  CountriesViewModel.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import Foundation
import Domain

public protocol CountriesViewModel {
    var numberOfCountries: Int { get }
    var error: String? { get }
    func fetchCountries(completion: @escaping (() -> Void))
    func countryAt(index: Int) -> Country
}

public class CountriesViewModelImpl: CountriesViewModel {
    private let useCase: CountriesUseCase

    private var countries: [Country] = []
    private var fetchCountriesError: String?

    public init(useCase: CountriesUseCase) {
        self.useCase = useCase
    }

    public func fetchCountries(completion: @escaping (() -> Void)) {
        useCase.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
            case .failure(let error):
                self?.fetchCountriesError = error.localizedDescription
            }
            completion()
        }
    }
}

extension CountriesViewModelImpl {
    public var numberOfCountries: Int {
        countries.count
    }
    
    public var error: String? {
        fetchCountriesError
    }

    public func countryAt(index: Int) -> Country {
        countries[index]
    }
}
