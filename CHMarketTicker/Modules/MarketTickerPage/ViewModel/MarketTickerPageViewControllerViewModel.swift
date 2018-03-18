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
    
    func buildViewModel(tickerViewModels: [TickerViewModel]) -> MarketTickerPageViewControllerViewModel {
        var marketTickerPageContentViewControllers = [MarketTickerPageContentViewController]()
        
        // Separating to different pair currencies
        var pairCurrencies = [String]()
        for i in 0..<tickerViewModels.count {
            let pairCurrency = tickerViewModels[i].pairCurrency
            if !pairCurrencies.contains(pairCurrency) {
                pairCurrencies.append(pairCurrency)
                continue
            }
        }
        
        // Building marketTickerPageContentViewController by different pair currencies
        for i in 0..<pairCurrencies.count {
            var tickerViewModelsOfPairCurrency = [TickerViewModel]()
            tickerViewModels.forEach({ (tickerViewModel) in
                if pairCurrencies[i].description == tickerViewModel.pairCurrency {
                    tickerViewModelsOfPairCurrency.append(tickerViewModel)
                }
            })
            
            let marketTickerPageContentViewController = MarketTickerPageContentDefaultBuilder().buildMarketTickerPageContentModule(pageIndex: i, tickerViewModelsOfPairCurrency: tickerViewModelsOfPairCurrency)
            marketTickerPageContentViewControllers.append(marketTickerPageContentViewController)
        }
        
        return MarketTickerPageViewControllerViewModel(marketTickerPageContentViewControllers: marketTickerPageContentViewControllers)
    }
    
}
