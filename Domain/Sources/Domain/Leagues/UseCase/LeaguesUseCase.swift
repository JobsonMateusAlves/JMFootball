//
//  LeaguesUseCase.swift
//  Domain
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation

// MARK: protocol
public protocol LeaguesUseCase {
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void)
    func fetchLeagues(by country: Country, completion: @escaping (Result<[League], Error>) -> Void)
    func fetchFavoriteLeagues(completion: @escaping (Result<[League], Error>) -> Void)
    func favoriteLeague(_ league: League, completion: @escaping (Result<League, Error>) -> Void)
}

// MARK: Implementation
public final class LeaguesUseCaseImpl: LeaguesUseCase {
    
    private let leaguesRepository: LeaguesRepository
    
    public init(leaguesRepository: LeaguesRepository) {
        self.leaguesRepository = leaguesRepository
    }
    
    public func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void) {
        leaguesRepository.fetchLeagues { result in
            switch result {
            case .success(let response):
                let leagues = response.sorted(by: { $0.id < $1.id })
                completion(.success(leagues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchLeagues(by country: Country, completion: @escaping (Result<[League], Error>) -> Void) {
        leaguesRepository.fetchLeagues(by: country) { result in
            switch result {
            case .success(let response):
                let leagues = response.sorted(by: { $0.id < $1.id })
                completion(.success(leagues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchFavoriteLeagues(completion: @escaping (Result<[League], Error>) -> Void) {
        leaguesRepository.fetchFavoriteLeagues(completion: completion)
    }
    
    public func favoriteLeague(_ league: League, completion: @escaping (Result<League, Error>) -> Void) {
        var newLeague = league
        newLeague.favorite.toggle()
        leaguesRepository.updateLeague(newLeague, completion: completion)
    }
}
