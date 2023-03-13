//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

extension UserDefaults {
    static let alreadySetPreferencesKey = "alreadySetPreferencesKey"
    
    public static func setAlreadySetPreferences(with value: Bool) {
        UserDefaults.standard.setValue(value, forKey: alreadySetPreferencesKey)
    }
    
    public static func alreadySetPreferences() -> Bool {
        UserDefaults.standard.bool(forKey: alreadySetPreferencesKey)
    }
}
