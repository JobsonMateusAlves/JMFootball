//
//  SportUseCase.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation

public protocol SportUseCaseProtocol {
    func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void)
}

public class SportUseCase: SportUseCaseProtocol {
    let repository: SportRepositoryProtocol
    
    public init(repository: SportRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void) {
        self.repository.fetchSports(completion: completion)
    }
}
