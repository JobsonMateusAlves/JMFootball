//
//  Sport.swift
//  Domain
//
//  Created by Jobson Mateus on 10/01/23.
//

import Foundation

public struct Sport: Codable {
    public let id: String
    public let name: String
    public let description: String
    
    public init(
        id: String,
        name: String,
        description: String
    ) {
        self.id = id
        self.name = name
        self.description = description
    }
}
