//
//  FavoriteLeaguesViewModel.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import Foundation
import Domain

public protocol FavoriteLeaguesViewModel {
    var numberOfLeagues: Int { get }
    var error: String? { get }
    func fetchFavoriteLeagues(completion: @escaping (() -> Void))
    func leagueAt(index: Int) -> League
}

public class FavoriteLeaguesViewModelImpl: FavoriteLeaguesViewModel {
    private let useCase: LeaguesUseCase

    private var leagues: [League] = []
    private var fetchLeaguesError: String?

    public init(useCase: LeaguesUseCase) {
        self.useCase = useCase
    }

    public func fetchFavoriteLeagues(completion: @escaping (() -> Void)) {
        useCase.fetchFavoriteLeagues { [weak self] result in
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

extension FavoriteLeaguesViewModelImpl {
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
