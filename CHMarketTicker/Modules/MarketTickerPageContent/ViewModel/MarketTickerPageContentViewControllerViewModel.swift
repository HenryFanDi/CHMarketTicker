//
//  MarketTickerPageContentViewControllerViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerPageContentViewControllerViewModel {
    private(set) var pageIndex: Int
    private(set) var tickersOfCurrency: [Ticker]
    private(set) var cellViewModels: [MarketTickerPageContentTableViewCellViewModel]
}

class MarketTickerPageContentViewControllerViewModelBuilder {
    
    func buildViewModel(pageIndex: Int, tickersOfCurrency: [Ticker]) -> MarketTickerPageContentViewControllerViewModel {
        var cellViewModels = [MarketTickerPageContentTableViewCellViewModel]()
        tickersOfCurrency.forEach { (ticker) in
            let cellViewModel = MarketTickerPageContentTableViewCellViewModelBuilder().buildViewModel(ticker: ticker)
            cellViewModels.append(cellViewModel)
        }
        return MarketTickerPageContentViewControllerViewModel(pageIndex: pageIndex, tickersOfCurrency: tickersOfCurrency, cellViewModels: cellViewModels)
    }
    
    // TODO: Notification for Update
    
}
