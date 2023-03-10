//
//  File.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public struct LeagueResponse: Codable {
    let get: String
    let leagues: [League]
    
    enum CodingKeys: String, CodingKey {
        case get
        case leagues = "response"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.get = try container.decode(String.self, forKey: .get)
        self.leagues = try container.decode([League].self, forKey: .leagues)
    }
    
    public func encode(to encoder: Encoder) throws {}
}
