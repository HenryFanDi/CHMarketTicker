//
//  MarketTickerPageContentTableViewCellViewModel.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct MarketTickerPageContentTableViewCellViewModel: MarketTickerPageContentTableViewCellPresentable {
    private(set) var tradingTitleString: String
    private(set) var tradingPairString: String
    private(set) var lastTradingPriceString: String
    private(set) var fluctuationPercentageString: String
    private(set) var fluctuationPercentageStringColor: UIColor
}

class MarketTickerPageContentTableViewCellViewModelBuilder {
    
    func buildViewModel(tickerViewModel: TickerViewModel) -> MarketTickerPageContentTableViewCellViewModel {
        return MarketTickerPageContentTableViewCellViewModel(tradingTitleString: tickerViewModel.tradingTitleString, tradingPairString: tickerViewModel.tradingPairString, lastTradingPriceString: tickerViewModel.lastTradingPriceString, fluctuationPercentageString: tickerViewModel.fluctuationPercentageString, fluctuationPercentageStringColor: tickerViewModel.fluctuationPercentageStringColor)
    }
    
}
