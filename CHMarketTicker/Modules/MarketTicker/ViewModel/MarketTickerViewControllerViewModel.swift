//
//  MarketTickerViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerViewControllerViewModel {
    var tickers: [Ticker]
}

class MarketTickerViewControllerViewModelBuilder {
    
    func buildViewModel(tickers: [Ticker]) -> MarketTickerViewControllerViewModel {
        return MarketTickerViewControllerViewModel(tickers: tickers)
    }
    
}
