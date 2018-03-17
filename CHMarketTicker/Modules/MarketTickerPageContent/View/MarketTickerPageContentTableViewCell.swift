//
//  MarketTickerPageContentTableViewCell.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentTableViewCellPresentable {
    var tradingTitleString: String { get }
    var tradingPairString: String { get }
    var lastTradingPriceString: String { get }
    var fluctuationPercentageString: String { get }
}

class MarketTickerPageContentTableViewCell: UITableViewCell {
    
    private var viewModel: MarketTickerPageContentTableViewCellPresentable! {
        didSet {
            tradingTitleLabel.text = viewModel.tradingTitleString
            tradingPairLabel.text = viewModel.tradingPairString
            lastTradingPriceLabel.text = viewModel.lastTradingPriceString
            fluctuationPercentageLabel.text = viewModel.fluctuationPercentageString
        }
    }
    
    @IBOutlet private weak var tradingTitleLabel: UILabel!
    @IBOutlet private weak var tradingPairLabel: UILabel!
    @IBOutlet private weak var lastTradingPriceLabel: UILabel!
    @IBOutlet private weak var fluctuationPercentageLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    
    func configure(viewModel: MarketTickerPageContentTableViewCellPresentable) {
        self.viewModel = viewModel
    }
    
}
