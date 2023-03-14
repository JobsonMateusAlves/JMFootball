//
//  Provider.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public class Provider<T: API> {
    
    public init() {}
    
    func request<V: Codable>(
        target: T,
        responseType: V.Type,
        completion: ((Result<V, Error>) -> Void)?
    ) {
        var components: URLComponents? = URLComponents(string: target.url)
        components?.queryItems = target.parameters?.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        guard let url: URL = components?.url else {
            DispatchQueue.main.async {
                completion?(.failure(APIError.invalidURL))
            }
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.httpBody = target.body
        target.headers?.forEach{ key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.requestFailed))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.invalidResponse))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.requestFailed))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(V.self, from: data)
                DispatchQueue.main.async {
                    completion?(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.invalidResponse))
                }
            }
        }
        .resume()
    }
}
