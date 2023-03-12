//
//  LeagueFactory.swift
//  JMFootball
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation
import Presentation
import Domain
import Data

protocol LeagueFactory {
    static func createViewModel() -> LeaguesViewModel
    static func createUseCase() -> LeaguesUseCase
    static func createRepository() -> LeaguesRepository
    static func createProvider() -> LeaguesProvider
}

final class LeaguesFactoryImpl: LeagueFactory {
    static func createViewModel() -> LeaguesViewModel {
        LeaguesViewModelImpl(useCase: createUseCase())
    }
    
    static func createUseCase() -> LeaguesUseCase {
        LeaguesUseCaseImpl(leaguesRepository: createRepository())
    }
    
    static func createRepository() -> LeaguesRepository {
        LeaguesRepositoryImpl(provider: createProvider())
    }
    
    static func createProvider() -> LeaguesProvider {
        LeaguesProviderImpl()
    }
}
