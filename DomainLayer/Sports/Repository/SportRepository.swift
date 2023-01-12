//
//  SportRepository.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation

public protocol SportRepositoryProtocol {
    func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void)
}

public class SportRepository: SportRepositoryProtocol {
    
    public init() {}
    
    public func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void) {
        // TODO: Add LocalDB and Service
        let sports: [Sport] = [
            Sport(id: "1", name: "Futebol", description: "Futebol é um esporte onde 2 times de 11 jogadores se enfrentam chutando uma bola e tentando fazer gols."),
            Sport(id: "2", name: "Basquete", description: "Basquete é um esporte legal."),
            Sport(id: "3", name: "Volei", description: "Volei é um esporte muito legal.")
        ]
        
        completion(.success(sports))
    }
}
