//
//  SportsRepository.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 12/01/23.
//
import Foundation

// MARK: protocol
public protocol SportsRepository {
    func fetchSports(completion: @escaping (Result<[Sport], Error>) -> Void)
}
