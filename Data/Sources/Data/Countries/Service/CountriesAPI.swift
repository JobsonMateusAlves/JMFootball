//
//  CountriesAPI.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

public enum CountriesAPI {
    case fetchCountries
}

extension CountriesAPI: API {
    public var baseURL: String {
        "https://v3.football.api-sports.io"
    }
    
    public var path: String {
        "/countries"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchCountries:
            return .GET
        }
    }
    
    public var parameters: [String : String?]? {
        nil
    }
    
    public var headers: [String : String]? {
        ["x-apisports-key": apiKey]
    }
}
