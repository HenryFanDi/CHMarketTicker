//
//  TickersManager.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

class TickersManager: ManagerProtocol {
    
    func initWithResponseObject(responseObject: Any) -> Any? {
        if let object = responseObject as? [String: AnyObject],
            let result = object["result"] as? [String: AnyObject],
            let tickers = result["tickers"] as? [[String: AnyObject]] {
            do {
                let tickersData = try JSONSerialization.data(withJSONObject: tickers, options: .prettyPrinted)
                return try JSONDecoder().decode([Ticker].self, from: tickersData)
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
