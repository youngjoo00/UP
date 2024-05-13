//
//  UpbitRouter.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Foundation

enum UpbitRouter {
    case market
}

extension UpbitRouter: TargetType {
    var baseURL: String {
        return "https://api.upbit.com"
    }
    
    var header: [String : String] {
        return [:]
    }
    
    var path: String {
        switch self {
        case .market:
            return "/v1/market/all"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .market:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var parameters: String? {
        nil
    }
    
    var body: Data? {
        nil
    }
    
    
}
