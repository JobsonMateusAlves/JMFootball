//
//  CountriesFactory.swift
//  JMFootball
//
//  Created by Jobson Mateus on 14/03/23.
//

import Foundation
import Presentation
import Domain
import Data

final class CountriesFactory {
    static func createViewModel() -> CountriesViewModel {
        CountriesViewModelImpl(useCase: createUseCase())
    }
    
    static func createUseCase() -> CountriesUseCase {
        CountriesUseCaseImpl(countriesRepository: createRepository())
    }
    
    static func createRepository() -> CountriesRepository {
        CountriesRepositoryImpl(provider: createProvider())
    }
    
    static func createProvider() -> CountriesProvider {
        CountriesProviderImpl()
    }
}
