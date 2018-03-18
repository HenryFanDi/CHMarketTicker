//
//  MarketTickerViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerViewControllerViewModel {
    private(set) var tickerViewModels: [TickerViewModel]
}

extension MarketTickerViewControllerViewModel {
    
    func subscribeTickers() -> [String] {
        var subscribers = [String]()
        tickerViewModels.forEach { (tickerViewModel) in
            let tickerRequest = TickerRequestBuilder().build(tradingPairId: tickerViewModel.ticker.tradingPairId)
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
    
    func updateTickersAfterSubscribed(responseString: String) {
        guard let jsonString = responseString.data(using: .utf8) else {
            return
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonString, options: []) else {
            return
        }
        
        guard let object = jsonObject as? [String: AnyObject] else {
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            return
        }
        
        if object["update"] != nil {
            guard let tickerUpdateResponse = try? JSONDecoder().decode(TickerUpdateResponse.self, from: jsonData) else {
                return
            }
            updateToLastestTicker(tickerUpdateResponse: tickerUpdateResponse)
        } else {
            guard let tickerResponse = try? JSONDecoder().decode(TickerResponse.self, from: jsonData) else {
                return
            }
            updateTickerViewModelChannelId(tickerResponse: tickerResponse)
        }
    }
    
    func updateToLastestTicker(tickerUpdateResponse: TickerUpdateResponse) {
        NotificationCenter.default.post(name: Notification.Name.didReceiveTickerUpdate, object: self, userInfo: [Notification.Name.didReceiveTickerUpdate: tickerUpdateResponse])
    }
    
    func updateTickerViewModelChannelId(tickerResponse: TickerResponse) {
        for (_, tickerViewModel) in tickerViewModels.enumerated() {
            if tickerViewModel.channelId == nil, tickerViewModel.ticker.tradingPairId == tickerResponse.tradingPairId {
                tickerViewModel.updateChannelId(channelId: tickerResponse.channelId)
                break
            }
        }
    }
    
}

class MarketTickerViewControllerViewModelBuilder {
    
    func buildViewModel(tickerViewModels: [TickerViewModel]) -> MarketTickerViewControllerViewModel {
        return MarketTickerViewControllerViewModel(tickerViewModels: tickerViewModels)
    }
    
}
