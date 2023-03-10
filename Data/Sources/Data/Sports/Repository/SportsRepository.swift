//
//  SportsRepository.swift
//  
//
//  Created by Jobson Mateus on 09/03/23.
//

import Foundation
import Domain

// TODO: Add DB
public final class SportsRepositoryImpl: Domain.SportsRepository {
    let provider: SportsProvider
    
    public init(provider: SportsProvider) {
        self.provider = provider
    }

    public func fetchSports(completion: @escaping (Result<[Domain.Sport], Error>) -> Void) {
        provider.fetchSports(completion: completion)
    }
}
