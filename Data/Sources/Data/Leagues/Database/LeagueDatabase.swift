//
//  File.swift
//  
//
//  Created by Jobson Mateus on 11/03/23.
//

import Foundation
import GRDB

protocol LeagueDatabase: Database {
    func insert(league: League) throws
    func insert(leagues: [League]) throws
    func get(by id: Int) throws -> League?
    func getAll() throws -> [League]
    func deleteAll() throws
}

extension League: PersistableRecord, FetchableRecord, TableRecord {
    public init(row: Row) {
        self.id = row["id"]
        self.name = row["name"]
        self.type = row["type"]
        self.logo = row["logo"]
        self.country = row["country"]
        self.countryFlag = row["countryFlag"]
    }
}

public final class LeagueDatabaseImpl: LeagueDatabase {
    
    let dbQueue: DatabaseQueue
    
    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }
    
    func createTable() throws  {
        try dbQueue.write { db in
            try db.create(
                table: "league",
                options: [.ifNotExists]
            ) { t in
                t.column("id", .integer).notNull()
                t.column("name", .text).notNull()
                t.column("type", .text).notNull()
                t.column("logo", .text).notNull()
                t.column("country", .text)
                t.column("countryFlag", .text)
                t.primaryKey(["id"], onConflict: .replace)
            }
        }
    }
    
    func insert(league: League) throws {
        try dbQueue.write { db in
            let statement: Statement = try db.makeStatement(
                literal: """
                    INSERT OR REPLACE INTO league (
                       \(Column("id")),
                       \(Column("name")),
                       \(Column("type")),
                       \(Column("logo")),
                       \(Column("country")),
                       \(Column("countryFlag"))
                    )
                    VALUES (?, ?, ?, ?, ?, ?)
                """
            )
            
            try statement.setArguments([
                league.id,
                league.name,
                league.type,
                league.logo,
                league.country,
                league.countryFlag
            ])
            
            try statement.execute()
        }
    }
    
    func insert(leagues: [League]) throws {
        try leagues.forEach { league in
            try insert(league: league)
        }
    }
    
    func get(by id: Int) throws -> League? {
        try dbQueue.read { db in
            let sql: String = """
                SELECT *
                FROM league
                WHERE id = \(id)
            """
            return try League.fetchOne(db, sql: sql)
        }
    }
    
    func getAll() throws -> [League] {
        try dbQueue.read { db in
            let sql: String = """
                SELECT *
                FROM league
            """
            return try League.fetchAll(db, sql: sql)
        }
    }
    
    func deleteAll() throws  {
        try dbQueue.read { db in
            _ = try League.deleteAll(db)
        }
    }
}

