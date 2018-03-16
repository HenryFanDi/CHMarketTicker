//
//  MarketTickerBuilder.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerBuilder: class {
}

class MarketTickerDefaultBuilder: MarketTickerBuilder {
    
    func buildMarketTickerModule() -> MarketTickerViewController {
        let view = MarketTickerViewController(nibName: MarketTickerViewController.identifier, bundle: nil)
        return view
    }
    
}
