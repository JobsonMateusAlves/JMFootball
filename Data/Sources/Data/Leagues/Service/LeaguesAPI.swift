//
//  LeaguesAPI.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public enum LeaguesAPI {
    case fetchLeagues
    case fetchLeaguesBy(country: String)
}

extension LeaguesAPI: API {
    public var baseURL: String {
        "https://v3.football.api-sports.io"
    }
    
    public var path: String {
        "/leagues"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchLeagues, .fetchLeaguesBy:
            return .GET
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .fetchLeagues:
            return nil
        case .fetchLeaguesBy(let country):
            return ["country": country]
        }
    }
    
    public var headers: [String : String]? {
        ["x-apisports-key": apiKey]
    }
    
    public var body: Data? {
        nil
    }
}
