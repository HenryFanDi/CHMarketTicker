//
//  MarketTickerPageInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageInteractor: class {
    func getMarketTickerViewModels() -> [TickerViewModel]
}

class MarketTickerPageDefaultInteractor: MarketTickerPageInteractor {
    
    private var tickerViewModels: [TickerViewModel]
    
    // MARK: - Initialize
    
    required init(tickerViewModels: [TickerViewModel]) {
        self.tickerViewModels = tickerViewModels
    }
    
    // MARK: - MarketTickerPageInteractor
    
    func getMarketTickerViewModels() -> [TickerViewModel] {
        return tickerViewModels
    }
    
}
