//
//  MarketTickerPageContentViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerPageContentViewControllerViewModel {
    private(set) var pageIndex: Int
    private(set) var tickersOfCurrency: [Ticker]
}

class MarketTickerPageContentViewControllerViewModelBuilder {
    
    func buildViewModel(pageIndex: Int, tickersOfCurrency: [Ticker]) -> MarketTickerPageContentViewControllerViewModel {
        return MarketTickerPageContentViewControllerViewModel(pageIndex: pageIndex, tickersOfCurrency: tickersOfCurrency)
    }
    
}
