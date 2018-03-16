//
//  CHAPIRouter.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit
import Alamofire

enum CHAPIRouter: URLRequestConvertible {
    
    case getMarketTickers()
    
    static let baseURLString = "https://api.cobinhood.com/v1"
    
    var method: HTTPMethod {
        switch self {
        case .getMarketTickers():
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getMarketTickers():
            return "/market/tickers"
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try CHAPIRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let withParameters: Parameters? = nil
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: withParameters)
        return urlRequest
    }
    
}
