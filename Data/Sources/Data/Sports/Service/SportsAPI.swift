//
//  SportsAPI.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public enum SportsAPI {
    case fetchSports
}

extension SportsAPI: API {
    public var baseURL: String {
        ""
    }
    
    public var path: String {
        ""
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchSports:
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
