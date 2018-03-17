//
//  MarketTickerPagePresenter.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPagePresenter: class {
    func loadMarketTickerPage()
}

protocol MarketTickerPagePresenterInteract: class {
    func didGetMarketTickersSuccess(tickers: [Ticker])
    func didGetMarketTickersFailure()
}

class MarketTickerPageDefaultPresenter: MarketTickerPagePresenter {
    
    private let view: MarketTickerPageScreen
    private let interactor: MarketTickerPageInteractor
    
    // MARK: - Initialize
    
    required init(view: MarketTickerPageScreen, interactor: MarketTickerPageInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - MarketTickerPagePresenter
    
    func loadMarketTickerPage() {
        interactor.getMarketTickers()
    }
    
}

// MARK: - MarketTickerPagePresenterInteract

extension MarketTickerPageDefaultPresenter: MarketTickerPagePresenterInteract {
    
    func didGetMarketTickersSuccess(tickers: [Ticker]) {
        print("didGetMarketTickersSuccess")
        let viewModel = MarketTickerPageViewControllerViewModelBuilder().buildViewModel(tickers: tickers)
        
        DispatchQueue.main.async { [unowned self] () in
            self.view.configureMarketTickerPage(viewModel: viewModel)
        }
    }
    
    func didGetMarketTickersFailure() {
        // TODO: Error handling
        print("didGetMarketTickersFailure")
    }
    
}
