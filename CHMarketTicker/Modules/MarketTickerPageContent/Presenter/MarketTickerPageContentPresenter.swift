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
        
        addNotificationObserver()
    }
    
    // MARK: - Lifecycle
    
    deinit {
        removeNotificationObserver()
    }
    
    // MARK: - MarketTickerPageContentPresenter
    
    func loadMarketTickerPageContent() {
        buildMarketTickerPageContent()
    }
    
    // MARK: - Private
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(forName: Notification.Name.didReceiveTickerUpdateUpdateLayout, object: nil, queue: OperationQueue.main) { [unowned self] (notification) in
            self.buildMarketTickerPageContent()
        }
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func buildMarketTickerPageContent() {
        let pageIndex = interactor.getPageIndex()
        let tickerViewModelsOfPairCurrency = interactor.getTickerViewModelsOfPairCurrency()
        let viewModel = MarketTickerPageContentViewControllerViewModelBuilder().buildViewModel(pageIndex: pageIndex, tickerViewModelsOfPairCurrency: tickerViewModelsOfPairCurrency)
        view?.configureMarketTickerPageContent(viewModel: viewModel)
    }
    
}
