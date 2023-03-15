//
//  File.swift
//  
//
//  Created by Jobson Mateus on 15/03/23.
//

import UIKit

class ImageLoader {
    
    private var task: URLSessionDataTask?
    
    func loadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                return
            }
            
            guard let imageData = data, self != nil else { return }
            
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
