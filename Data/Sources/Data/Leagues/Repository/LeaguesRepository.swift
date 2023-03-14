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
        
        provider.fetchLeagues { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveLeagues(leagues: response.leagues)
                let leagues: [League] = (try? AppDatabase.shared?.leagueDatabase.getAll()) ?? []
                completion(.success(leagues.map({ $0.asPresentationModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchLeagues(by country: Domain.Country, completion: @escaping (Result<[Domain.League], Error>) -> Void) {
        let dbLeagues = (try? AppDatabase.shared?.leagueDatabase.get(by: Country(from: country))) ?? []
        
        if !dbLeagues.isEmpty {
            completion(.success(dbLeagues.map({ $0.asPresentationModel() })))
            return
        }
        
        provider.fetchLeagues { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveLeagues(leagues: response.leagues)
                let leagues: [League] = (try? AppDatabase.shared?.leagueDatabase.get(by: Country(from: country))) ?? []
                completion(.success(leagues.map({ $0.asPresentationModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchFavoriteLeagues(completion: @escaping (Result<[Domain.League], Error>) -> Void) {
        let savedLeagues = (try? AppDatabase.shared?.leagueDatabase.getAll()) ?? []
        let favoritedLeagues = savedLeagues//.filter({ $0.favorite })
        completion(.success(favoritedLeagues.map({ $0.asPresentationModel() })))
    }
}

extension LeaguesRepositoryImpl {
    private func saveLeagues(leagues: [League]) {
        var newLeagues = leagues
        let savedLeagues = (try? AppDatabase.shared?.leagueDatabase.getAll()) ?? []
        let favoritedLeagues = savedLeagues.filter({ $0.favorite })
        
        favoritedLeagues.forEach { league in
            if let index = newLeagues.firstIndex(where: { $0.id == league.id }) {
                newLeagues[index].favorite = true
            }
        }
        
        try? AppDatabase.shared?.leagueDatabase.deleteAll()
        try? AppDatabase.shared?.leagueDatabase.insert(leagues: newLeagues)
    }
}
