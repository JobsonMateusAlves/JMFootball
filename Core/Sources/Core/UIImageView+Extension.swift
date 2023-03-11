//
//  File.swift
//  
//
//  Created by Jobson Mateus on 11/03/23.
//

import UIKit

// TODO: Improve
extension UIImageView {
    public func setImage(with url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                return
            }
            
            guard let imageData = data, self != nil else { return }
            
            DispatchQueue.main.async {
                self?.image = UIImage(data: imageData)
            }
        }
        task.resume()
    }
}

