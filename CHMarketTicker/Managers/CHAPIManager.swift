//
//  CHAPIManager.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

class CHAPIManager: NSObject {
    
    // MARK: - Singleton Pattern
    
    static let shared = CHAPIManager()
    
    // MARK: - Public
    
    // GET
    
    func getMarketTickers() {
        CHAPIClient.shared.fetch(request: CHAPIRouter.getMarketTickers(), headers: [:]) { [unowned self] (result) in
            self.resultHandler(result: result, completion: { (responseValue) in
                if let response = responseValue {
                    print(response)
                }
            })
        }
    }
    
    // MARK: - Private
    
    private func resultHandler(result: ResultType<Any>, completion: @escaping (_ responseValue: Any?) -> Void) {
        switch result {
        case .successWithResponseValue(let responseValue):
            completion(responseValue)
            break
        case .failureWithErrorCode(let errorCode):
            print("errorCode : \(errorCode)")
            break
        }
    }

}
