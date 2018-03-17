//
//  MarketTickerPageContentBuilder.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentBuilder: class {
    func buildMarketTickerPageContentModule(pageIndex: Int, tickersOfPairCurrency: [Ticker]) -> MarketTickerPageContentViewController
}

class MarketTickerPageContentDefaultBuilder: MarketTickerPageContentBuilder {
    
    func buildMarketTickerPageContentModule(pageIndex: Int, tickersOfPairCurrency: [Ticker]) -> MarketTickerPageContentViewController {
        let viewController = MarketTickerPageContentViewController(nibName: MarketTickerPageContentViewController.identifier, bundle: nil)
        let interactor = MarketTickerPageContentDefaultInteractor(pageIndex: pageIndex, tickersOfPairCurrency: tickersOfPairCurrency)
        let presenter = MarketTickerPageContentDefaultPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
    
}
