//
//  File.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import Foundation

// MARK: protocol
public protocol CountriesUseCase {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

// MARK: Implementation
public final class CountriesUseCaseImpl: CountriesUseCase {
    
    private let countriesRepository: CountriesRepository
    
    public init(countriesRepository: CountriesRepository) {
        self.countriesRepository = countriesRepository
    }
    
    public func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        countriesRepository.fetchCountries { result in
            switch result {
            case .success(let response):
                let leagues = response.sorted(by: { $0.name < $1.name })
                completion(.success(leagues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
