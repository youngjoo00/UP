//
//  TargetType.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol TargetType {
    var baseURL: String { get }
    var header: [String: String] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: String? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL.appending(path))
        components?.queryItems = queryItems

        guard let url = components?.url else { throw URLError(.badURL) }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            urlRequest.httpBody = parameters.data(using: .utf8)
        } else {
            urlRequest.httpBody = body
        }
        return urlRequest
    }
}
