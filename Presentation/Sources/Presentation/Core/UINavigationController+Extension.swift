//
//  File.swift
//  
//
//  Created by Jobson Mateus on 15/03/23.
//

import UIKit

extension UINavigationController {
    func shouldHideBackButton() -> Bool {
        viewControllers.count <= 1
    }
}
