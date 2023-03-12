//
//  File.swift
//  
//
//  Created by Jobson Mateus on 11/03/23.
//

import Foundation
import GRDB

public final class AppDatabase {
    public static let shared: AppDatabase? = {
        try? AppDatabase()
    }()
    
    var dbQueue: DatabaseQueue
    var leagueDatabase: LeagueDatabase
    
    private init() throws {
        let url = try AppDatabase.getDirectoryURL()
        dbQueue = try DatabaseQueue(path: url.path)
        leagueDatabase = LeagueDatabaseImpl(dbQueue: dbQueue)
        
        debugPrint("DATABASE: \(url.path)")
    }
    
    public func initialize() {
        try? leagueDatabase.createTable()
    }
    
    private static func getDirectoryURL() throws -> URL {
        let fileManager: FileManager = FileManager()
        let folderURL: URL = try fileManager
            .url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent(
                "database",
                isDirectory: true
            )
        
        try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        return folderURL.appendingPathComponent("JMFootbalDB.sqlite")
    }
}

