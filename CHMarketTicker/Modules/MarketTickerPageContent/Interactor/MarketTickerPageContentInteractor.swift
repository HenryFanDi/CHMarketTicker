//
//  MarketTickerPageContentInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentInteractor: class {
    func getPageIndex() -> Int
    func getTickersOfPairCurrency() -> [Ticker]
}

class MarketTickerPageContentDefaultInteractor: MarketTickerPageContentInteractor {
    
    private var pageIndex: Int
    private var tickersOfPairCurrency: [Ticker]
    
    // MARK: - Initialize
    
    required init(pageIndex: Int, tickersOfPairCurrency: [Ticker]) {
        self.pageIndex = pageIndex
        self.tickersOfPairCurrency = tickersOfPairCurrency
    }
    
    // MARK: - MarketTickerPageContentInteractor
    
    func getPageIndex() -> Int {
        return pageIndex
    }
    
    func getTickersOfPairCurrency() -> [Ticker] {
        return tickersOfPairCurrency
    }
    
}
