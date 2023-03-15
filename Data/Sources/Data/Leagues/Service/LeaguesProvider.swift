//
//  LeaguesProvider.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation
import Domain

public protocol LeaguesProvider {
    func fetchLeagues(completion: @escaping (Result<LeagueResponse, Error>) -> Void)
    func fetchLeagues(by country: Country, completion: @escaping (Result<LeagueResponse, Error>) -> Void)
}

public final class LeaguesProviderImpl: Provider<LeaguesAPI>, LeaguesProvider {
    public func fetchLeagues(completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        request(target: .fetchLeagues, responseType: LeagueResponse.self, completion: completion)
    }
    
    public func fetchLeagues(by country: Country, completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        request(target: .fetchLeaguesBy(country: country.name), responseType: LeagueResponse.self, completion: completion)
    }
}
