//
//  API.swift
//  
//
//  Created by Jobson Mateus on 10/03/23.
//

import Foundation

public enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

public protocol API {
    var baseURL: String { get }
    var path: String { get }
    var url: String { get }

    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
}

extension API {
    public var url: String {
        baseURL + path
    }
}
