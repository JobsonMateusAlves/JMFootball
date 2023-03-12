//
//  LeaguesViewModel.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import Domain

public class LeaguesViewModel {
    private let useCase: LeaguesUseCase

    private var leagues: [League] = []
    var fetchLeaguesError: String?

    public init(useCase: LeaguesUseCase) {
        self.useCase = useCase
    }

    func fetchLeagues(completion: @escaping (() -> Void)) {
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

extension LeaguesViewModel {
    var numberOfLeagues: Int {
        leagues.count
    }
    
    var error: String? {
        fetchLeaguesError
    }

    func leagueAt(index: Int) -> League {
        leagues[index]
    }
}
