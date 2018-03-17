//
//  MarketTickerPageContentTableViewCellViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerPageContentTableViewCellViewModel: MarketTickerPageContentTableViewCellPresentable {
    var tradingTitleString: String
    var tradingPairString: String
    var lastTradingPriceString: String
    var fluctuationPercentageString: String
}

class MarketTickerPageContentTableViewCellViewModelBuilder {
    
    func buildViewModel(ticker: Ticker) -> MarketTickerPageContentTableViewCellViewModel {
        let tradingTitleString = ticker.currency
        let tradingPairString = ticker.tradingPairId
        let lastTradingPriceString = ticker.lastTradePrice
        
        let lastTradePrice: Float = Float(ticker.lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(ticker.openOf24h) ?? 0.0
        let fluctuationPercentage = ((lastTradePrice - openOf24h) / openOf24h) * 100
        let fluctuationSymbol = fluctuationPercentage > 0.0 ? "+" : "-"
        let fluctuationPercentageString = String(format: "%@%.2f %%", fluctuationSymbol, fabs(fluctuationPercentage))
        
        return MarketTickerPageContentTableViewCellViewModel(tradingTitleString: tradingTitleString, tradingPairString: tradingPairString, lastTradingPriceString: lastTradingPriceString, fluctuationPercentageString: fluctuationPercentageString)
    }
    
}
