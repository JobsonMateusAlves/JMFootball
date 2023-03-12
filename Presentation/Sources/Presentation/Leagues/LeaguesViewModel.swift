//
//  LeaguesViewModel.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import Domain

public protocol LeaguesViewModel {
    var numberOfLeagues: Int { get }
    var error: String? { get }
    func fetchLeagues(completion: @escaping (() -> Void))
    func leagueAt(index: Int) -> League
}

public class LeaguesViewModelImpl: LeaguesViewModel {
    private let useCase: LeaguesUseCase

    private var leagues: [League] = []
    private var fetchLeaguesError: String?

    public init(useCase: LeaguesUseCase) {
        self.useCase = useCase
    }

    public func fetchLeagues(completion: @escaping (() -> Void)) {
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
}

extension LeaguesViewModelImpl {
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
