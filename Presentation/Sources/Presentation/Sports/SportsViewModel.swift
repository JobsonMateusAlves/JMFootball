//
//  SportsViewModel.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import Domain

public class SportsViewModel {
    private let useCase: SportsUseCase

    private var sports: [Sport] = []

    public init(useCase: SportsUseCase) {
        self.useCase = useCase
    }

    func fetchSports(completion: @escaping (() -> Void)) {
        useCase.fetchSports { [weak self] result in
            switch result {
            case .success(let sports):
                self?.sports = sports
                completion()
                
            case .failure:
                // TODO: Error handling
                break
            }
        }
    }
}

extension SportsViewModel {
    var numberOfSports: Int {
        sports.count
    }

    func sportAt(index: Int) -> Sport {
        sports[index]
    }
}
