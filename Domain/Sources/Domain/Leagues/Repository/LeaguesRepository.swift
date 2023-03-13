//
//  LeaguesRepository.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 12/01/23.
//

import Foundation

// MARK: protocol
public protocol LeaguesRepository {
    func fetchLeagues(completion: @escaping (Result<[League], Error>) -> Void)
}
