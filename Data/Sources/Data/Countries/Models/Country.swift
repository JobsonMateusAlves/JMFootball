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
