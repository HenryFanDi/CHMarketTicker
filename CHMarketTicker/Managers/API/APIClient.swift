//
//  APIClient.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit
import Alamofire

enum ResultType<T> {
    case successWithResponseValue(responseValue: T)
    case failureWithErrorCode(errorCode: Int)
}

enum HTTPStatusCode: Int {
    case success = 200
    case badRequest = 400
    case notFound = 404
}

protocol CHAPIProtocol {
    func fetch(request: URLRequestConvertible, headers: [String: String]?, completion: @escaping (ResultType<Any>) -> ())
}

class APIClient: CHAPIProtocol {
    
    private let sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    
    // MARK: - Singleton Pattern
    
    static let shared = APIClient()
    
    // MARK: - Public
    
    func fetch(request: URLRequestConvertible, headers: [String: String]?, completion: @escaping (ResultType<Any>) -> ()) {
        sessionManager.session.getAllTasks { (task) in
            task.forEach{ $0.cancel() }
        }
        
        sessionManager.request(request).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { (dataResponse) in
            // Get the status code of response
            if let response = dataResponse.response {
                let statusCode = response.statusCode
                
                switch statusCode {
                case HTTPStatusCode.success.rawValue:
                    // Get the response object
                    if let responseValue = dataResponse.result.value {
                        completion(ResultType.successWithResponseValue(responseValue: responseValue))
                    }
                    break
                case HTTPStatusCode.badRequest.rawValue, HTTPStatusCode.notFound.rawValue:
                    completion(ResultType.failureWithErrorCode(errorCode: statusCode))
                    break
                default:
                    break
                }
            } else {
            }
        }
    }
    
}
