//
//  File.swift
//  
//
//  Created by Jobson Mateus on 16/03/23.
//

import Foundation

struct Configs {
    private static let footballApiKey = "footballApiKey"
    static var apiFootballApiKey: String {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else {
            return ""
        }
        
        if let apiKey: String = infoDictionary[footballApiKey] as? String {
            return apiKey.replacingOccurrences(of: " ", with: "")
        }
        
        return ""
    }
}
