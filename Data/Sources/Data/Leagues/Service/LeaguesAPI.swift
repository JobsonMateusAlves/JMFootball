//
//  LeaguesAPI.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public enum LeaguesAPI {
    case fetchLeagues
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
        case .fetchLeagues:
            return .GET
        }
    }
    
    public var parameters: [String : String?]? {
        nil
    }
    
    public var headers: [String : String]? {
        nil
    }
}
