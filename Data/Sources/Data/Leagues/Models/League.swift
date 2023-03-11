//
//  File.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation
import Domain

public struct League: Codable {
    let id: Int
    let name: String
    let type: String
    let logo: String
    let country: String
    let countryFlag: String?
    
    enum CodingKeys: CodingKey {
        case league
        case country
        
        case id
        case name
        case logo
        case type
        case flag
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let leagueContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .league)
        let countryContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .country)

        id = try leagueContainer.decode(Int.self, forKey: .id)
        name = try leagueContainer.decode(String.self, forKey: .name)
        type = try leagueContainer.decode(String.self, forKey: .type)
        logo = try leagueContainer.decode(String.self, forKey: .logo)
        country = try countryContainer.decode(String.self, forKey: .name)
        countryFlag = try countryContainer.decodeIfPresent(String.self, forKey: .flag)
    }
    
    public func encode(to encoder: Encoder) throws {}
}

extension League {
    func asPresentationModel() -> Domain.League {
        Domain.League(id: id, name: name, type: type, logo: logo, country: country, countryFlag: countryFlag)
    }
}
