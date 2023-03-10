//
//  SportsUseCase.swift
//  Domain
//
//  Created by Jobson Mateus on 12/01/23.
//
import Foundation

// MARK: protocol
public protocol SportsUseCase {
    func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void)
}

// MARK: Implementation
public final class SportsUseCaseImpl: SportsUseCase {
    
    private let sportsRepository: SportsRepository
    
    public init(sportsRepository: SportsRepository) {
        self.sportsRepository = sportsRepository
    }
    
    public func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void) {
        sportsRepository.fetchSports(completion: completion)
    }
}
