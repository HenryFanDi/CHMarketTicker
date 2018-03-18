//
//  MarketTickerBuilder.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerBuilder: class {
    func buildMarketTickerModule() -> MarketTickerViewController
}

class MarketTickerDefaultBuilder: MarketTickerBuilder {
    
    func buildMarketTickerModule() -> MarketTickerViewController {
        let viewController = MarketTickerViewController(nibName: MarketTickerViewController.identifier, bundle: nil)
        let interactor = MarketTickerDefaultInteractor()
        let presenter = MarketTickerDefaultPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
    
}
