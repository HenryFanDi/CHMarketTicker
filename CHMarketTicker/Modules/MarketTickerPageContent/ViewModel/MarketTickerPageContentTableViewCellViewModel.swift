//
//  MarketTickerPageContentTableViewCellViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

// TODO: class
struct MarketTickerPageContentTableViewCellViewModel: MarketTickerPageContentTableViewCellPresentable {
    private(set) var tradingTitleString: String
    private(set) var tradingPairString: String
    private(set) var lastTradingPriceString: String
    private(set) var fluctuationPercentageString: String
}

class MarketTickerPageContentTableViewCellViewModelBuilder {
    
    func buildViewModel(tickerViewModel: TickerViewModel) -> MarketTickerPageContentTableViewCellViewModel {
        addNotificationObserver()
        
        let ticker = tickerViewModel.ticker
        let tradingTitleString = tickerViewModel.currency
        let tradingPairString = ticker.tradingPairId
        let lastTradingPriceString = ticker.lastTradePrice
        
        let lastTradePrice: Float = Float(ticker.lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(ticker.openOf24h) ?? 0.0
        let fluctuationPercentage = ((lastTradePrice - openOf24h) / openOf24h) * 100
        let fluctuationSymbol = fluctuationPercentage > 0.0 ? "+" : "-"
        let fluctuationPercentageString = String(format: "%@%.2f %%", fluctuationSymbol, fabs(fluctuationPercentage))
        
        return MarketTickerPageContentTableViewCellViewModel(tradingTitleString: tradingTitleString, tradingPairString: tradingPairString, lastTradingPriceString: lastTradingPriceString, fluctuationPercentageString: fluctuationPercentageString)
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(forName: Notification.Name.didReceiveTickerUpdate, object: nil, queue: OperationQueue.main) { (notification) in
            if let tickerUpdateResponse = notification.userInfo?[Notification.Name.didReceiveTickerUpdate] as? TickerUpdateResponse {
                print(tickerUpdateResponse)
            }
        }
    }
    
}
