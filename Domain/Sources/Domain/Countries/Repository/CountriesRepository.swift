//
//  CountriesRepository.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

// MARK: protocol
public protocol CountriesRepository {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}
