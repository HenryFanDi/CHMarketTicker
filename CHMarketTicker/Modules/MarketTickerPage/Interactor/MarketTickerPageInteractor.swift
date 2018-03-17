//
//  MarketTickerPageInteractor.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageInteractor: class {
    func getMarketTickers()
}

class MarketTickerPageDefaultInteractor: MarketTickerPageInteractor {
    
    var presenter: MarketTickerPagePresenterInteract!
    
    // MARK: - MarketTickerPageInteractor
    
    func getMarketTickers() {
        CHAPIManager.shared.getMarketTickers(success: { [weak self] (tickers) in
            self?.presenter.didGetMarketTickersSuccess(tickers: tickers)
            }, failure: { [weak self] () in
                self?.presenter.didGetMarketTickersFailure()
        })
    }
    
}
