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
    private(set) var cellViewModels: [MarketTickerPageContentTableViewCellViewModel]
}

class MarketTickerPageContentViewControllerViewModelBuilder {
    
    func buildViewModel(pageIndex: Int, tickerViewModelsOfPairCurrency: [TickerViewModel]) -> MarketTickerPageContentViewControllerViewModel {
        var cellViewModels = [MarketTickerPageContentTableViewCellViewModel]()
        tickerViewModelsOfPairCurrency.forEach { (tickerViewModel) in
            let cellViewModel = MarketTickerPageContentTableViewCellViewModelBuilder().buildViewModel(tickerViewModel: tickerViewModel)
            cellViewModels.append(cellViewModel)
        }
        return MarketTickerPageContentViewControllerViewModel(pageIndex: pageIndex, cellViewModels: cellViewModels)
    }
    
    // TODO: Notification for Update
    
}
