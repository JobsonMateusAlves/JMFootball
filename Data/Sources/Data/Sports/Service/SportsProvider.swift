//
//  SportsProvider.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation
import Domain

public protocol SportsProvider {
    func fetchSports(completion: @escaping (Result<[Domain.Sport], Error>) -> Void)
}

public final class SportsProviderImpl: Provider<SportsAPI>, SportsProvider {
    public func fetchSports(completion: @escaping (Result<[Domain.Sport], Error>) -> Void) {
        request(target: .fetchSports, responseType: [Domain.Sport].self, completion: completion)
    }
}
