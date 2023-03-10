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
        var httpBody: Data?
        var components: URLComponents? = URLComponents(string: target.url)
        
        if let parameters = target.parameters {
            switch target.method {
            case .POST:
                httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            default:
                components?.queryItems = parameters.map { key, value in
                    URLQueryItem(name: key, value: value)
                }
            }
        }
        
        guard let url: URL = components?.url else {
            completion?(.failure(APIError.invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.httpBody = httpBody
        target.headers?.forEach{ key, value in
            request.setValue(key, forHTTPHeaderField: value)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion?(.failure(APIError.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion?(.failure(APIError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion?(.failure(APIError.requestFailed))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(V.self, from: data)
                completion?(.success(response))
            } catch {
                completion?(.failure(APIError.invalidResponse))
            }
        }
        .resume()
    }
}
