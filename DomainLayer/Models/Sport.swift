//
//  Sport.swift
//  DomainLayer
//
//  Created by Jobson Mateus on 10/01/23.
//

import Foundation

public struct Sport: Codable {
    let id: String
    let name: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case name = "strSport"
        case description = "strSportDescription"
    }
    
    public init() {
        self.id = ""
        self.name = ""
        self.description = ""
    }
}
