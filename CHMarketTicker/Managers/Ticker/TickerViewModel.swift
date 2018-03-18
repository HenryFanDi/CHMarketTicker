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
    private(set) var fluctuationPercentageStringColor: UIColor
    
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
    
    init(ticker: Ticker, tradingPairString: String, lastTradingPriceString: String, fluctuationPercentageString: String, fluctuationPercentageStringColor: UIColor) {
        self.ticker = ticker
        self.tradingPairString = tradingPairString
        self.lastTradingPriceString = lastTradingPriceString
        self.fluctuationPercentageString = fluctuationPercentageString
        self.fluctuationPercentageStringColor = fluctuationPercentageStringColor
        
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
        let fluctuationPercentageStringColor = getFluctuationPercentageStringColor(lastTradePrice: ticker.lastTradePrice, openOf24h: ticker.openOf24h)
        return TickerViewModel(ticker: ticker, tradingPairString: tradingPairString, lastTradingPriceString: lastTradingPriceString, fluctuationPercentageString: fluctuationPercentageString, fluctuationPercentageStringColor: fluctuationPercentageStringColor)
    }
    
    // MARK: - Public
    
    func getFluctuationPercentageString(lastTradePrice: String, openOf24h: String) -> String {
        let lastTradePrice: Float = Float(lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(openOf24h) ?? 0.0
        let fluctuationPercentage = lastTradePrice != 0.0 && openOf24h != 0.0 ? Float(((lastTradePrice - openOf24h) / openOf24h) * 100) : 0.0
        let fluctuationSymbol = fluctuationPercentage != 0.0 ? fluctuationPercentage > 0.0 ? "+" : "-" : ""
        let fluctuationPercentageString = String(format: "%@%.2f %%", fluctuationSymbol, fabs(fluctuationPercentage))
        return fluctuationPercentageString
    }
    
    func getFluctuationPercentageStringColor(lastTradePrice: String, openOf24h: String) -> UIColor {
        let lastTradePrice: Float = Float(lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(openOf24h) ?? 0.0
        let fluctuationPercentage = lastTradePrice != 0.0 && openOf24h != 0.0 ? Float(((lastTradePrice - openOf24h) / openOf24h) * 100) : 0.0
        let greenColor = UIColor(red: 17.0/255.0, green: 218.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        let redColor = UIColor(red: 218.0/255.0, green: 83.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        let fluctuationPercentageStringColor = fluctuationPercentage > 0.0 ? greenColor : redColor
        return fluctuationPercentageStringColor
    }
    
}
