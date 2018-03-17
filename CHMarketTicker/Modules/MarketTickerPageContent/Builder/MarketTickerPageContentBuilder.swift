//
//  MarketTickerPageContentBuilder.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentBuilder: class {
    func buildMarketTickerPageContentModule() -> MarketTickerPageContentViewController
}

class MarketTickerPageContentDefaultBuilder: MarketTickerPageContentBuilder {
    
    func buildMarketTickerPageContentModule() -> MarketTickerPageContentViewController {
        let viewController = MarketTickerPageContentViewController(nibName: MarketTickerPageContentViewController.identifier, bundle: nil)
        let presenter = MarketTickerPageContentDefaultPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
}
