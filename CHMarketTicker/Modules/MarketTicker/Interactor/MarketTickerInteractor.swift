//
//  MarketTickerInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerInteractor: class {
    func getMarketTickers()
}

class MarketTickerDefaultInteractor: MarketTickerInteractor {
    
    var presenter: MarketTickerPresenterInteract!
    
    // MARK: - MarketTickerInteractor
    
    func getMarketTickers() {
        CHAPIManager.shared.getMarketTickers(success: { [unowned self] (tickers) in
            self.presenter.didGetMarketTickersSuccess(tickers: tickers)
            }, failure: { [unowned self] () in
                self.presenter.didGetMarketTickersFailure()
        })
    }
    
}
