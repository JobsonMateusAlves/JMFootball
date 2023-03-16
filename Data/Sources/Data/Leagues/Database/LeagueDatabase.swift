//
//  File.swift
//  
//
//  Created by Jobson Mateus on 11/03/23.
//

import Foundation
import GRDB

protocol LeagueDatabase {
    func createTable() throws
    func insert(league: League) throws
    func insert(leagues: [League]) throws
    func get(by id: Int) throws -> League?
    func get(by country: Country) throws -> [League]
    func getAll() throws -> [League]
    func deleteAll() throws
}

extension League: PersistableRecord, FetchableRecord, TableRecord {
    public init(row: Row) {
        self.id = row["id"]
        self.name = row["name"]
        self.type = row["type"]
        self.logo = row["logo"]
        if let countryRow = row.scopes["country"] {
            self.country = Country(row: countryRow)
        } else {
            self.country = Country(name: "Erro", code: nil, flag: nil)
        }
        self.favorite = row["favorite"]
    }
}

public final class LeagueDatabaseImpl: LeagueDatabase {
    let dbQueue: DatabaseQueue
    
    private let countryAssociation: HasOneAssociation<League, Country> = League.hasOne(
        Country.self,
        using: ForeignKey(
            ["name"],
            to: ["countryName"]
        )
    )
    
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
                t.column("countryName", .text).notNull()
                t.column("favorite", .boolean).notNull()
                t.primaryKey(["id"], onConflict: .replace)
            }
        }
    }
    
    func insert(league: League) throws {
        try dbQueue.write{ db in
            try league.insert(in: db)
            try league.country.insert(db)
        }
    }
    
    func insert(leagues: [League]) throws {
        try leagues.forEach { league in
            try insert(league: league)
        }
    }
    
    func get(by id: Int) throws -> League? {
        try dbQueue.read { db in
            let statement: QueryInterfaceRequest<League> = League.filter(key: id).including(required: countryAssociation)
            return try statement.fetchOne(db)
        }
    }
    
    func get(by country: Country) throws -> [League] {
        try dbQueue.read { db in
            let statement: QueryInterfaceRequest<League> = League
                .filter(Column("countryName") == country.name)
                .including(required: countryAssociation)
            return try statement.fetchAll(db)
        }
    }
    
    func getAll() throws -> [League] {
        try dbQueue.read { db in
            let statement: QueryInterfaceRequest<League> = League.including(required: countryAssociation)
            return try statement.fetchAll(db)
        }
    }
    
    func deleteAll() throws  {
        try dbQueue.read { db in
            _ = try League.deleteAll(db)
        }
    }
}

