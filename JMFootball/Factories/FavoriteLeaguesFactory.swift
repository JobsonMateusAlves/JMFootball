//
//  FavoriteLeaguesFactory.swift
//  JMFootball
//
//  Created by Jobson Mateus on 13/03/23.
//

import Foundation
import Presentation
import Domain
import Data

final class FavoriteLeaguesFactory {
    static func createViewModel() -> FavoriteLeaguesViewModel {
        FavoriteLeaguesViewModelImpl(useCase: createUseCase())
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
