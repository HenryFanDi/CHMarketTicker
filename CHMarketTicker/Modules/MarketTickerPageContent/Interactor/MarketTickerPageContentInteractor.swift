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
    func getTickersOfCurrency() -> [Ticker]
}

class MarketTickerPageContentDefaultInteractor: MarketTickerPageContentInteractor {
    
    private var pageIndex: Int
    private var tickersOfCurrency: [Ticker]
    
    // MARK: - Initialize
    
    required init(pageIndex: Int, tickersOfCurrency: [Ticker]) {
        self.pageIndex = pageIndex
        self.tickersOfCurrency = tickersOfCurrency
    }
    
    // MARK: - MarketTickerPageContentInteractor
    
    func getPageIndex() -> Int {
        return pageIndex
    }
    
    func getTickersOfCurrency() -> [Ticker] {
        return tickersOfCurrency
    }
    
}
