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
    
    private let view: MarketTickerPageScreen
    private let interactor: MarketTickerPageInteractor
    
    // MARK: - Initialize
    
    required init(view: MarketTickerPageScreen, interactor: MarketTickerPageInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - MarketTickerPagePresenter
    
    func loadMarketTickerPage() {
        let tickerViewModels = interactor.getMarketTickerViewModels()
        let viewModel = MarketTickerPageViewControllerViewModelBuilder().buildViewModel(tickerViewModels: tickerViewModels)
        view.configureMarketTickerPage(viewModel: viewModel)
    }
    
}
