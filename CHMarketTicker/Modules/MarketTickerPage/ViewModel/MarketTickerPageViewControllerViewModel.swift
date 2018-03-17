//
//  MarketTickerPageViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerPageViewControllerViewModel {
    
    private(set) var marketTickerPageContentViewControllers: [MarketTickerPageContentViewController]
    
}

class MarketTickerPageViewControllerViewModelBuilder {
    
    func buildViewModel(tickers: [Ticker]) -> MarketTickerPageViewControllerViewModel {
        var marketTickerPageContentViewControllers = [MarketTickerPageContentViewController]()
        
        // Separating to different currencies
        var currencies = [String]()
        for i in 0..<tickers.count {
            let currency = tickers[i].currency
            if !currencies.contains(currency) {
                currencies.append(currency)
                continue
            }
        }
        
        // Building marketTickerPageContentViewController by different currencies
        for i in 0..<currencies.count {
            var tickersOfCurrency = [Ticker]()
            tickers.forEach({ (ticker) in
                if currencies[i].description == ticker.currency {
                    tickersOfCurrency.append(ticker)
                }
            })
            
            let marketTickerPageContentViewController = MarketTickerPageContentDefaultBuilder().buildMarketTickerPageContentModule(tickersOfCurrency: tickersOfCurrency)
            marketTickerPageContentViewControllers.append(marketTickerPageContentViewController)
        }
        
        return MarketTickerPageViewControllerViewModel(marketTickerPageContentViewControllers: marketTickerPageContentViewControllers)
    }
    
}
