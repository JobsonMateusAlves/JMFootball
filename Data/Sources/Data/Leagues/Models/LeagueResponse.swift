//
//  File.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public struct LeagueResponse: Codable {
    let leagues: [League]
    
    enum CodingKeys: String, CodingKey {
        case leagues = "response"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.leagues = try container.decode([League].self, forKey: .leagues)
    }
    
    public func encode(to encoder: Encoder) throws {}
}
