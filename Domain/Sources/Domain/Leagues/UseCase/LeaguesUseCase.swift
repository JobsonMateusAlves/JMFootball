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
                let leagues = response.filter({ $0.country.lowercased() != "world" }).sorted(by: { $0.id < $1.id })
                completion(.success(leagues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
