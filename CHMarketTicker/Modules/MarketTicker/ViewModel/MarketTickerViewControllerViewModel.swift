//
//  MarketTickerViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerViewControllerViewModel {
    var tickers: [Ticker]
}

extension MarketTickerViewControllerViewModel {
    
    func subscribeTickers() -> [String] {
        var subscribers = [String]()
        // TODO: TickerViewModel
        tickers.forEach { (ticker) in
            let tickerRequest = TickerRequestBuilder().build(tradingPairId: ticker.tradingPairId)
            if let encodeData = tickerRequest.encode() {
                if let decodeData = try? JSONDecoder().decode(TickerRequest.self, from: encodeData) {
                    if let jsonData = decodeData.encode(), let jsonString = String(data: jsonData, encoding: .utf8) {
                        subscribers.append(jsonString)
                    }
                }
            }
        }
        return subscribers
    }
    
    func updateChannelIdAfterSubscribed(responseString: String) {
        guard let jsonString = responseString.data(using: .utf8) else {
            return
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonString, options: []) else {
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            return
        }
        
        guard let tickerResponse = try? JSONDecoder().decode(TickerResponse.self, from: jsonData) else {
            return
        }
        
        for (_, ticker) in tickers.enumerated() {
            if ticker.tradingPairId == tickerResponse.tradingPairId {
                print(tickerResponse)
                break
            }
        }
    }
    
}

class MarketTickerViewControllerViewModelBuilder {
    
    func buildViewModel(tickers: [Ticker]) -> MarketTickerViewControllerViewModel {
        // TODO: TickerViewModel
        return MarketTickerViewControllerViewModel(tickers: tickers)
    }
    
}
