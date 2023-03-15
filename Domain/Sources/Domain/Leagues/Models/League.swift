//
//  League.swift
//  Domain
//
//  Created by Jobson Mateus on 10/01/23.
//

import Foundation

public struct League {
    public let id: Int
    public let name: String
    public let type: String
    public let logo: String
    public let country: Country
    public let favorite: Bool
    
    public init(
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
}
