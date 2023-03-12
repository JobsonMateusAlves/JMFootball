//
//  File.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation
import Domain
import GRDB

public struct League: Codable {
    let id: Int
    let name: String
    let type: String
    let logo: String
    let country: Country
    
    enum CodingKeys: CodingKey {
        case league
        case country
        
        case id
        case name
        case logo
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let leagueContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .league)

        id = try leagueContainer.decode(Int.self, forKey: .id)
        name = try leagueContainer.decode(String.self, forKey: .name)
        type = try leagueContainer.decode(String.self, forKey: .type)
        logo = try leagueContainer.decode(String.self, forKey: .logo)
        country = try container.decode(Country.self, forKey: .country)
    }
    
    public func encode(to encoder: Encoder) throws {}
}

extension League {
    func insert(in db: Database) throws {
        let statement: Statement = try db.makeStatement(
            literal: """
                INSERT OR REPLACE INTO league (
                   \(Column("id")),
                   \(Column("name")),
                   \(Column("type")),
                   \(Column("logo")),
                   \(Column("countryName"))
                )
                VALUES (?, ?, ?, ?, ?)
            """
        )
        
        try statement.setArguments([
            id,
            name,
            type,
            logo,
            country.name,
        ])
        
        try statement.execute()
    }
}

extension League {
    func asPresentationModel() -> Domain.League {
        Domain.League(id: id, name: name, type: type, logo: logo, country: country.asPresentationModel())
    }
}
