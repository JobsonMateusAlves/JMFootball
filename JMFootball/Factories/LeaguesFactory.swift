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

final class LeaguesFactory {
    static func createViewModel(with country: Domain.Country? = nil) -> LeaguesViewModel {
        LeaguesViewModelImpl(useCase: createUseCase(), country: country)
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
