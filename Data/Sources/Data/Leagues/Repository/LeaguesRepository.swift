//
//  LeaguesRepository.swift
//  
//
//  Created by Jobson Mateus on 09/03/23.
//

import Foundation
import Domain

// TODO: Add DB
public final class LeaguesRepositoryImpl: Domain.LeaguesRepository {
    let provider: LeaguesProvider
    
    public init(provider: LeaguesProvider) {
        self.provider = provider
    }

    public func fetchLeagues(completion: @escaping (Result<[Domain.League], Error>) -> Void) {
        provider.fetchLeagues { result in
            switch result {
            case .success(let response):
                completion(.success(response.leagues.map({ $0.asPresentationModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
