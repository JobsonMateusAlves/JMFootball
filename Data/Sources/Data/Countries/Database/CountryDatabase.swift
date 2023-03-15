//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation
import GRDB

protocol CountryDatabase {
    func createTable() throws
    func insert(country: Country) throws
    func insert(countries: [Country]) throws
    func get(by name: Int) throws -> Country?
    func getAll() throws -> [Country]
    func deleteAll() throws
}

extension Country: PersistableRecord, FetchableRecord, TableRecord {
    public init(row: Row) {
        self.name = row["name"]
        self.code = row["code"]
        self.flag = row["flag"]
    }
}

public final class CountryDatabaseImpl: CountryDatabase {
    
    let dbQueue: DatabaseQueue
    
    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }
    
    func createTable() throws  {
        try dbQueue.write { db in
            try db.create(
                table: "country",
                options: [.ifNotExists]
            ) { t in
                t.column("name", .text).notNull()
                t.column("code", .text)
                t.column("flag", .text)
                t.primaryKey(["name"], onConflict: .ignore)
            }
        }
    }
    
    func insert(country: Country) throws {
        try dbQueue.write { db in
            try country.insert(in: db)
        }
    }
    
    func insert(countries: [Country]) throws {
        try countries.forEach { country in
            try insert(country: country)
        }
    }
    
    func get(by name: Int) throws -> Country? {
        try dbQueue.read { db in
            return try Country.fetchOne(db, key: name)
        }
    }
    
    func getAll() throws -> [Country] {
        try dbQueue.read { db in
            return try Country.fetchAll(db)
        }
    }
    
    func deleteAll() throws  {
        try dbQueue.read { db in
            _ = try Country.deleteAll(db)
        }
    }
}


