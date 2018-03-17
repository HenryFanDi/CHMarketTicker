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
        let viewController = MarketTickerPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let interactor = MarketTickerPageDefaultInteractor()
        let presenter = MarketTickerPageDefaultPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
    
}
