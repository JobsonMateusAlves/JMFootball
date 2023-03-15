//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation
import GRDB
import Domain

public struct Country: Codable {
    let name: String
    var code: String?
    var flag: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        if let countryCode = self.code {
            self.flag = "https://flagsapi.com/\(countryCode)/flat/64.png"
        }
    }
    
    public init(
        name: String,
        code: String? = nil,
        flag: String? = nil
    ) {
        self.name = name
        self.code = code
        self.flag = flag
    }
}

extension Country {
    func insert(in db: Database) throws {
        let statement: Statement = try db.makeStatement(
            literal: """
                INSERT OR IGNORE INTO country (
                   \(Column("name")),
                   \(Column("code")),
                   \(Column("flag"))
                )
                VALUES (?, ?, ?)
            """
        )
        
        try statement.setArguments([
            name,
            code,
            flag
        ])
        
        try statement.execute()
    }
}

extension Country {
    init(from presentationModel: Domain.Country) {
        self.name = presentationModel.name
        self.code = presentationModel.code
        self.flag = presentationModel.flag
    }
    
    func asPresentationModel() -> Domain.Country {
        Domain.Country(name: name, code: code, flag: flag)
    }
}
