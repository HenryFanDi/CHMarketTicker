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
    func getTickerViewModelsOfPairCurrency() -> [TickerViewModel]
}

class MarketTickerPageContentDefaultInteractor: MarketTickerPageContentInteractor {
    
    private var pageIndex: Int
    private var tickerViewModelsOfPairCurrency: [TickerViewModel]
    
    // MARK: - Initialize
    
    required init(pageIndex: Int, tickerViewModelsOfPairCurrency: [TickerViewModel]) {
        self.pageIndex = pageIndex
        self.tickerViewModelsOfPairCurrency = tickerViewModelsOfPairCurrency
    }
    
    // MARK: - MarketTickerPageContentInteractor
    
    func getPageIndex() -> Int {
        return pageIndex
    }
    
    func getTickerViewModelsOfPairCurrency() -> [TickerViewModel] {
        return tickerViewModelsOfPairCurrency
    }
    
}
