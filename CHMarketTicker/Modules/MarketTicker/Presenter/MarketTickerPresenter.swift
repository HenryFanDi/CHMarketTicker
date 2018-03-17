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

class MarketTickerDefaultPresenter: MarketTickerPresenter {
    
    private weak var view: MarketTickerScreen?
    
    // MARK: - Initialize
    
    required init(view: MarketTickerScreen) {
        self.view = view
    }
    
    // MARK: - MarketTickerPresenter
    
    func loadMarketTicker() {
        let viewModel = MarketTickerViewControllerViewModelBuilder().buildViewModel()
        view?.configureMarketTicker(viewModel: viewModel)
    }
    
}
