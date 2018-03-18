//
//  MarketTickerPresenter.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPresenter: class {
    func loadMarketTicker()
}

protocol MarketTickerPresenterInteract: class {
    func didGetMarketTickersSuccess(tickers: [Ticker])
    func didGetMarketTickersFailure()
}

class MarketTickerDefaultPresenter: MarketTickerPresenter {
    
    fileprivate weak var view: MarketTickerScreen?
    private let interactor: MarketTickerInteractor
    
    // MARK: - Initialize
    
    required init(view: MarketTickerScreen, interactor: MarketTickerInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - MarketTickerPresenter
    
    func loadMarketTicker() {
        interactor.getMarketTickers()
    }
    
}

// MARK: - MarketTickerPresenterInteract

extension MarketTickerDefaultPresenter: MarketTickerPresenterInteract {
    
    func didGetMarketTickersSuccess(tickers: [Ticker]) {
        print("didGetMarketTickersSuccess")
        
        let viewModel = MarketTickerViewControllerViewModelBuilder().buildViewModel(tickers: tickers)
        
        DispatchQueue.main.async { [unowned self] () in
            self.view?.configureMarketTicker(viewModel: viewModel)
        }
    }
    
    func didGetMarketTickersFailure() {
        // TODO: Error handling
        print("didGetMarketTickersFailure")
    }
    
}
