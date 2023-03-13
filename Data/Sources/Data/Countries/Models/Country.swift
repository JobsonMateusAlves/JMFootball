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
    let code: String?
    let flag: String?
}

extension Country {
    func insert(in db: Database) throws {
        let statement: Statement = try db.makeStatement(
            literal: """
                INSERT INTO country (
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
    func asPresentationModel() -> Domain.Country {
        Domain.Country(name: name, code: code, flag: flag)
    }
}
