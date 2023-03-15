//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import Foundation

extension UserDefaults {
    static let alreadySetFavoritesKey = "alreadySetFavoritesKey"
    
    public static func setAlreadySetFavorites(with value: Bool) {
        UserDefaults.standard.setValue(value, forKey: alreadySetFavoritesKey)
    }
    
    public static func alreadySetFavorites() -> Bool {
        UserDefaults.standard.bool(forKey: alreadySetFavoritesKey)
    }
}
