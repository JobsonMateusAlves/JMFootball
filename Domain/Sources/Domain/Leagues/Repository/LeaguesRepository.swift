//
//  LeaguesRepository.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation

// MARK: protocol
public protocol LeaguesRepository {
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void)
    func fetchLeagues(by country: Country, completion: @escaping (Result<[League], Error>) -> Void)
    func fetchFavoriteLeagues(completion: @escaping (Result<[League], Error>) -> Void)
    func updateLeague(_ league: League, completion: @escaping (Result<League, Error>) -> Void)
}
