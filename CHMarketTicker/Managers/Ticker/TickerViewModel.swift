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
    
    var currency: String {
        return ticker.tradingPairId.components(separatedBy: "-").first ?? ""
    }
    
    var pairCurrency: String {
        return ticker.tradingPairId.components(separatedBy: "-").last ?? ""
    }
    
    init(ticker: Ticker) {
        self.ticker = ticker
    }
    
    func updateChannelId(channelId: String) {
        self.channelId = channelId
    }
    
}

class TickerViewModelBuilder {
    
    func buildViewModel(ticker: Ticker) -> TickerViewModel {
        return TickerViewModel(ticker: ticker)
    }
    
}
