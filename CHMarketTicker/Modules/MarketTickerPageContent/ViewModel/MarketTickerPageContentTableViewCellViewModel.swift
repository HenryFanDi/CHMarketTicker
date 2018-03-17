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
    
    func buildViewModel(viewModel: Ticker) -> MarketTickerPageContentTableViewCellViewModel {
        let tradingTitleString = viewModel.currency
        let tradingPairString = viewModel.tradingPairId
        let lastTradingPriceString = viewModel.lastTradePrice
        
        let lastTradePrice: Float = Float(viewModel.lastTradePrice) ?? 0.0
        let openOf24h: Float = Float(viewModel.openOf24h) ?? 0.0
        let fluctuationPercentage = ((lastTradePrice - openOf24h) / openOf24h) * 100
        let fluctuationPercentageString = String(format: "%.2f %", fluctuationPercentage)
        
        return MarketTickerPageContentTableViewCellViewModel(tradingTitleString: tradingTitleString, tradingPairString: tradingPairString, lastTradingPriceString: lastTradingPriceString, fluctuationPercentageString: fluctuationPercentageString)
    }
    
}
