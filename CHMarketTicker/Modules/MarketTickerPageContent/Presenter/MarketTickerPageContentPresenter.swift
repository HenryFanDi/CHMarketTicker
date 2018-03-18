//
//  MarketTickerPageContentPresenter.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentPresenter: class {
    func loadMarketTickerPageContent()
}

class MarketTickerPageContentDefaultPresenter: MarketTickerPageContentPresenter {
    
    private weak var view: MarketTickerPageContentScreen?
    private var interactor: MarketTickerPageContentInteractor
    
    // MARK: - Initialize
    
    required init(view: MarketTickerPageContentScreen, interactor: MarketTickerPageContentInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - MarketTickerPageContentPresenter
    
    func loadMarketTickerPageContent() {
        let pageIndex = interactor.getPageIndex()
        let tickerViewModelsOfPairCurrency = interactor.getTickerViewModelsOfPairCurrency()
        let viewModel = MarketTickerPageContentViewControllerViewModelBuilder().buildViewModel(pageIndex: pageIndex, tickerViewModelsOfPairCurrency: tickerViewModelsOfPairCurrency)
        view?.configureMarketTickerPageContent(viewModel: viewModel)
    }
    
}
