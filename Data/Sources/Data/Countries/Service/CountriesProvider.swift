//
//  CountriesProvider.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation
import Domain

public protocol CountriesProvider {
    func fetchCountries(completion: @escaping (Result<CountryResponse, Error>) -> Void)
}

public final class CountriesProviderImpl: Provider<CountriesAPI>, CountriesProvider {
    public func fetchCountries(completion: @escaping (Result<CountryResponse, Error>) -> Void) {
        request(target: .fetchCountries, responseType: CountryResponse.self, completion: completion)
    }
}
