//
//  MarketTickerPageContentInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentInteractor: class {
    func getTickersOfCurrency() -> [Ticker]
}

class MarketTickerPageContentDefaultInteractor: MarketTickerPageContentInteractor {
    
    private var tickersOfCurrency: [Ticker]
    
    // MARK: - Initialize
    
    required init(tickersOfCurrency: [Ticker]) {
        self.tickersOfCurrency = tickersOfCurrency
    }
    
    // MARK: - MarketTickerPageContentInteractor
    
    func getTickersOfCurrency() -> [Ticker] {
        return tickersOfCurrency
    }
    
}
