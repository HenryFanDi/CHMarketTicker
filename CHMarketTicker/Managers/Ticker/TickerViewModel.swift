//
//  TickerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

class TickerViewModel {
    
    private(set) var ticker: Ticker
    private(set) var channelId: String?
    
    private(set) var tradingPairString: String
    private(set) var lastTradingPriceString: String
    private(set) var fluctuationPercentageString: String
    
    var tradingTitleString: String {
        return currency
    }
    
    var currency: String {
        return ticker.tradingPairId.components(separatedBy: "-").first ?? ""
    }
    
    var pairCurrency: String {
        return ticker.tradingPairId.components(separatedBy: "-").last ?? ""
    }
    
    // MARK: - Lifecycle
    
    deinit {
        removeNotificationObserver()
    }
    
    // MARK: - Initialize
    
    init(ticker: Ticker, tradingPairString: String, lastTradingPriceString: String, fluctuationPercentageString: String) {
        self.ticker = ticker
        self.tradingPairString = tradingPairString
        self.lastTradingPriceString = lastTradingPriceString
        self.fluctuationPercentageString = fluctuationPercentageString
        
        addNotificationObserver()
    }
    
    // MARK: - Public
    
    func updateChannelId(channelId: String) {
        self.channelId = channelId
    }
    
    // MARK: - Private
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(forName: Notification.Name.didReceiveTickerUpdate, object: nil, queue: OperationQueue.main) { [unowned self] (notification) in
            if let tickerUpdateResponse = notification.userInfo?[Notification.Name.didReceiveTickerUpdate] as? TickerUpdateResponse {
                if self.channelId == tickerUpdateResponse.channelId {
                    self.updateTicker(tickerUpdateResponse: tickerUpdateResponse)
                }
            }
        }
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateTicker(tickerUpdateResponse: TickerUpdateResponse) {
        print(tickerUpdateResponse)
        // PRICE
        let lastTradePrice = tickerUpdateResponse.update[1]
        
        // 24H_OPEN
        let openOf24h = tickerUpdateResponse.update[7]
        
        self.lastTradingPriceString = lastTradePrice
        self.fluctuationPercentageString = TickerViewModelBuilder().getFluctuationPercentageString(lastTradePrice: lastTradePrice, openOf24h: openOf24h)
        
        NotificationCenter.default.post(name: Notification.Name.didReceiveTickerUpdateUpdateLayout, object: nil, userInfo: [:])
    }
    
}

class TickerViewModelBuilder {
    
    func buildViewModel(ticker: Ticker) -> TickerViewModel {
        let tradingPairString = ticker.tradingPairId
        let lastTradingPriceString = ticker.lastTradePrice
        let fluctuationPercentageString = getFluctuationPercentageString(lastTradePrice: ticker.lastTradePrice, openOf24h: ticker.openOf24h)
        return TickerViewModel(ticker: ticker, tradingPairString: tradingPairString, lastTradingPriceString: lastTradingPriceString, fluctuationPercentageString: fluctuationPercentageString)
    }
    
    // MARK: - Public
    
    func getFluctuationPercentageString(lastTradePrice: String, openOf24h: String) -> String {
        let lastTradePrice: Float = Float(lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(openOf24h) ?? 0.0
        let fluctuationPercentage = ((lastTradePrice - openOf24h) / openOf24h) * 100
        let fluctuationSymbol = fluctuationPercentage > 0.0 ? "+" : "-"
        let fluctuationPercentageString = String(format: "%@%.2f %%", fluctuationSymbol, fabs(fluctuationPercentage))
        return fluctuationPercentageString
    }
    
}
