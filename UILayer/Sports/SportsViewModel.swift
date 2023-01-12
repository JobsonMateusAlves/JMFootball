//
//  SportsViewModel.swift
//  UILayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import DomainLayer

protocol SportsViewModelDelegate: AnyObject {
    func sportsViewModel(_ viewModel: SportsViewModel, didUpdateSports sports: [Sport])
}

public class SportsViewModel {
    weak var delegate: SportsViewModelDelegate?
    private let sportUseCase: SportUseCaseProtocol
    
    private var sports: [Sport] = [] {
        didSet {
            delegate?.sportsViewModel(self, didUpdateSports: sports)
        }
    }
    
    public init() {
        // TODO: Dependency injection
        sportUseCase = SportUseCase(repository: SportRepository())
    }
    
    func fetchSports() {
        // TODO: Add Requests
        sportUseCase.fetchSports { [weak self] result in
            switch result {
            case .success(let sports):
                self?.sports = sports
            case .failure:
                // TODO: Error handling
                break
            }
        }
    }
}

extension SportsViewModel {
    var numberOfSports: Int {
        self.sports.count
    }
    
    func sportAt(index: Int) -> Sport {
        self.sports[index]
    }
}
