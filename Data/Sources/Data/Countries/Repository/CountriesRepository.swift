//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation
import Domain

public final class CountriesRepositoryImpl: Domain.CountriesRepository {
    let provider: CountriesProvider
    
    public init(provider: CountriesProvider) {
        self.provider = provider
    }

    public func fetchCountries(completion: @escaping (Result<[Domain.Country], Error>) -> Void) {
        let dbCountries = (try? AppDatabase.shared?.countryDatabase.getAll()) ?? []
        completion(.success(dbCountries.map({ $0.asPresentationModel() })))
        
        provider.fetchCountries { result in
            switch result {
            case .success(let response):
                try? AppDatabase.shared?.countryDatabase.insert(countries: response.countries)
                let countries: [Country] = (try? AppDatabase.shared?.countryDatabase.getAll()) ?? []
                completion(.success(countries.map({ $0.asPresentationModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

