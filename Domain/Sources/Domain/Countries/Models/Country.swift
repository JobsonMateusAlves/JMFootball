//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

public struct Country {
    public let name: String
    public let code: String?
    public let flag: String?
    
    public init(
        name: String,
        code: String?,
        flag: String?
    ) {
        self.name = name
        self.code = code
        self.flag = flag
    }
}
