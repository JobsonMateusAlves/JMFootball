//
//  SportsViewModel.swift
//  UILayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation
import DomainLayer

protocol SportsViewModelDelegate: class {
    func sportsViewModel(_ viewModel: SportsViewModel, didUpdateSports sports: [Sport])
}

public class SportsViewModel {
    weak var delegate: SportsViewModelDelegate?
    
    private var sports: [Sport] = [] {
        didSet {
            delegate?.sportsViewModel(self, didUpdateSports: sports)
        }
    }
    
    public init() {}
    
    func fetchSports() {
        // TODO: Add Requests
        let sports: [Sport] = [
            Sport(id: "1", name: "Futebol", description: "Futebol é um esporte onde 2 times de 11 jogadores se enfrentam chutando uma bola e tentando fazer gols."),
            Sport(id: "2", name: "Basquete", description: "Basquete é um esporte legal."),
            Sport(id: "3", name: "Volei", description: "Volei é um esporte muito legal.")
        ]
        
        self.sports = sports
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
