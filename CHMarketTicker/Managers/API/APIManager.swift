//
//  APIManager.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol ManagerProtocol {
    func initWithResponseObject(responseObject: Any) -> Any?
}

class APIManager {
    
    // MARK: - Singleton Pattern
    
    static let shared = APIManager()
    
    // MARK: - Public
    
    // GET
    
    func getMarketTickers(success: @escaping (_ tickers: [Ticker]) -> (), failure: @escaping () -> ()) {
        APIClient.shared.fetch(request: APIRouter.getMarketTickers(), headers: [:]) { [unowned self] (result) in
            self.resultHandler(result: result, completion: { (responseValue) in
                if let response = responseValue,
                    let tickers = TickersManager().initWithResponseObject(responseObject: response) as? [Ticker] {
                    success(tickers)
                } else {
                    failure()
                }
            })
        }
    }
    
    // MARK: - Private
    
    private func resultHandler(result: ResultType<Any>, completion: @escaping (_ responseValue: Any?) -> ()) {
        switch result {
        case .successWithResponseValue(let responseValue):
            completion(responseValue)
            break
        case .failureWithErrorCode(let errorCode):
            print("errorCode : \(errorCode)")
            completion(nil)
            break
        }
    }

}
