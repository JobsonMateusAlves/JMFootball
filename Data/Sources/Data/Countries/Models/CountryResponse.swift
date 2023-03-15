//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

public struct CountryResponse: Codable {
    let countries: [Country]
    
    enum CodingKeys: String, CodingKey {
        case countries = "response"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.countries = try container.decode([Country].self, forKey: .countries)
    }
    
    public func encode(to encoder: Encoder) throws {}
}
