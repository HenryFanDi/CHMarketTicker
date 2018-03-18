//
//  MarketTickerPageInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageInteractor: class {
    func getMarketTickers() -> [Ticker]
}

class MarketTickerPageDefaultInteractor: MarketTickerPageInteractor {
    
    private var tickers: [Ticker]
    
    // MARK: - Initialize
    
    required init(tickers: [Ticker]) {
        self.tickers = tickers
    }
    
    // MARK: - MarketTickerPageInteractor
    
    func getMarketTickers() -> [Ticker] {
        return tickers
    }
    
}
