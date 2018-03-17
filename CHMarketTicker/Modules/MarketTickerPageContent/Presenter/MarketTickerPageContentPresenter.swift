//
//  MarketTickerPageContentPresenter.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentPresenter: class {
    
}

class MarketTickerPageContentDefaultPresenter: MarketTickerPageContentPresenter {
    
    private weak var view: MarketTickerPageContentScreen?
    
    // MARK: - Initialize
    
    required init(view: MarketTickerPageContentScreen) {
        self.view = view
    }
    
    // MARK: - MarketTickerPageContentPresenter
    
    func loadMarketTickerPageContent() {
        let viewModel = MarketTickerPageContentViewControllerViewModelBuilder().buildViewModel()
        view?.configureMarketTickerPageContent(viewModel: viewModel)
    }
    
}
