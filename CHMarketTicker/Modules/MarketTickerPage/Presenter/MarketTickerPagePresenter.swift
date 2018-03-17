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

class MarketTickerPageDefaultPresenter: MarketTickerPagePresenter {
    
    private weak var view: MarketTickerPageScreen?
    
    // MARK: - Initialize
    
    required init(view: MarketTickerPageScreen) {
        self.view = view
    }
    
    // MARK: - MarketTickerPagePresenter
    
    func loadMarketTickerPage() {
        let viewModel = MarketTickerPageViewControllerViewModelBuilder().buildViewModel()
        view?.configureMarketTickerPage(viewModel: viewModel)
    }
    
}
