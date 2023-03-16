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
    var favorite: Bool = false
    
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
    
    init(
        id: Int,
        name: String,
        type: String,
        logo: String,
        country: Country,
        favorite: Bool
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.logo = logo
        self.country = country
        self.favorite = favorite
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
                    \(Column("countryName")),
                    \(Column("favorite"))
                )
                VALUES (?, ?, ?, ?, ?, ?)
            """
        )
        
        try statement.setArguments([
            id,
            name,
            type,
            logo,
            country.name,
            favorite
        ])
        
        try statement.execute()
    }
}

extension League {
    init(from presentationModel: Domain.League) {
        self.id = presentationModel.id
        self.name = presentationModel.name
        self.type = presentationModel.type
        self.logo = presentationModel.logo
        self.country = Country(from: presentationModel.country)
        self.favorite = presentationModel.favorite
    }
    
    func asPresentationModel() -> Domain.League {
        Domain.League(id: id, name: name, type: type, logo: logo, country: country.asPresentationModel(), favorite: favorite)
    }
}
