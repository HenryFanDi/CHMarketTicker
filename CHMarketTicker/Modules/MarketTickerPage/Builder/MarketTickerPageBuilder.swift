//
//  MarketTickerPageBuilder.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageBuilder: class {
    func buildMarketTickerPageModule() -> MarketTickerPageViewController
}

class MarketTickerPageDefaultBuilder: MarketTickerPageBuilder {
    
    func buildMarketTickerPageModule() -> MarketTickerPageViewController {
        let viewController = MarketTickerPageViewController()
        return viewController
    }
    
}
