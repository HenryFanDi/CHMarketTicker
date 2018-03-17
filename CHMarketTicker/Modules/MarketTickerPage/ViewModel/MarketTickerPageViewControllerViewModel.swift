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
        
        // Separating to different pair currencies
        var pairCurrencies = [String]()
        for i in 0..<tickers.count {
            let pairCurrency = tickers[i].pairCurrency
            if !pairCurrencies.contains(pairCurrency) {
                pairCurrencies.append(pairCurrency)
                continue
            }
        }
        
        // Building marketTickerPageContentViewController by different pair currencies
        for i in 0..<pairCurrencies.count {
            var tickersOfPairCurrency = [Ticker]()
            tickers.forEach({ (ticker) in
                if pairCurrencies[i].description == ticker.pairCurrency {
                    tickersOfPairCurrency.append(ticker)
                }
            })
            
            let marketTickerPageContentViewController = MarketTickerPageContentDefaultBuilder().buildMarketTickerPageContentModule(pageIndex: i, tickersOfPairCurrency: tickersOfPairCurrency)
            marketTickerPageContentViewControllers.append(marketTickerPageContentViewController)
        }
        
        return MarketTickerPageViewControllerViewModel(marketTickerPageContentViewControllers: marketTickerPageContentViewControllers)
    }
    
}
