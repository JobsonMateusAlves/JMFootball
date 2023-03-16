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
    func leagueAt(index: Int) -> League
}

public class LeaguesViewModelImpl: LeaguesViewModel {
    
    private let useCase: LeaguesUseCase

    private var leagues: [League] = []
    private var country: Country?
    private var fetchLeaguesError: String?

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
}

extension LeaguesViewModelImpl {
    public var selectedCountry: Country? {
        country
    }
    
    public var numberOfLeagues: Int {
        leagues.count
    }
    
    public var error: String? {
        fetchLeaguesError
    }

    public func leagueAt(index: Int) -> League {
        leagues[index]
    }
}
