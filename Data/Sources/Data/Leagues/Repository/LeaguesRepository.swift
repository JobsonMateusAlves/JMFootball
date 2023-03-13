//
//  LeaguesRepository.swift
//  
//
//  Created by Jobson Mateus on 09/03/23.
//

import Foundation
import Domain

public final class LeaguesRepositoryImpl: Domain.LeaguesRepository {
    let provider: LeaguesProvider
    
    public init(provider: LeaguesProvider) {
        self.provider = provider
    }

    public func fetchLeagues(completion: @escaping (Result<[Domain.League], Error>) -> Void) {
        let dbLeagues = (try? AppDatabase.shared?.leagueDatabase.getAll()) ?? []
        completion(.success(dbLeagues.map({ $0.asPresentationModel() })))
        
        provider.fetchLeagues { result in
            switch result {
            case .success(let response):
                try? AppDatabase.shared?.leagueDatabase.insert(leagues: response.leagues)
                let leagues: [League] = (try? AppDatabase.shared?.leagueDatabase.getAll()) ?? []
                completion(.success(leagues.map({ $0.asPresentationModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
