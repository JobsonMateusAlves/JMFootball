//
//  LeaguesViewModel.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import Domain

public protocol LeaguesViewModel {
    var selectedCountry: Country? { get }
    var numberOfLeagues: Int { get }
    var error: String? { get }
    func fetchLeagues(completion: @escaping (() -> Void))
    func fetchLeagues(by country: Country, completion: @escaping (() -> Void))
    func favoriteLeague(league: League)
    func leagueAt(index: Int) -> League
}

public class LeaguesViewModelImpl: LeaguesViewModel {
    
    private let useCase: LeaguesUseCase

    private var leagues: [League] = []
    private var country: Country?
    private var fetchLeaguesError: String?
    private var favoriteLeagueError: String?

    public init(useCase: LeaguesUseCase, country: Country?) {
        self.useCase = useCase
        self.country = country
    }

    public func fetchLeagues(completion: @escaping (() -> Void)) {
        if let country = country {
            fetchLeagues(by: country, completion: completion)
            return
        }
        
        useCase.fetchLeagues { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.leagues = leagues
                completion()
                
            case .failure(let error):
                self?.fetchLeaguesError = error.localizedDescription
                completion()
            }
        }
    }
    
    public func fetchLeagues(by country: Country, completion: @escaping (() -> Void)) {
        useCase.fetchLeagues(by: country) { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.leagues = leagues
                completion()
                
            case .failure(let error):
                self?.fetchLeaguesError = error.localizedDescription
                completion()
            }
        }
    }
    
    public func favoriteLeague(league: Domain.League) {
        if let index = leagues.firstIndex(where: { $0.id == league.id }) {
            useCase.favoriteLeague(league) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.leagues[index] = response
                case .failure(let error):
                    self?.favoriteLeagueError = error.localizedDescription
                }
            }
        }
    }
}

extension LeaguesViewModelImpl {
    public var selectedCountry: Country? {
        country
    }
    
    public var numberOfLeagues: Int {
        leagues.count
    }
    
    public var error: String? {
        if let error = fetchLeaguesError {
            return error
        }
        
        if let error = favoriteLeagueError {
            return error
        }
        
        return nil
    }

    public func leagueAt(index: Int) -> League {
        leagues[index]
    }
}
