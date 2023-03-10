//
//  SportsRepository.swift
//  
//
//  Created by Jobson Mateus on 09/03/23.
//

import Foundation
import Domain

public final class SportsRepositoryImpl: Domain.SportsRepository {
    public init() {}

    public func fetchSports(completion: @escaping (Result<[Domain.Sport], Error>) -> Void) {
        completion(.success([Sport(id: "1", name: "Soccer", description: "Soccer description")]))
    }
}
