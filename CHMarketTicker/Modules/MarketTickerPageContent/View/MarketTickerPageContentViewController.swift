//
//  MarketTickerPageContentViewController.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageContentScreen: class {
    func configureMarketTickerPageContent(viewModel: MarketTickerPageContentViewControllerViewModel)
}

class MarketTickerPageContentViewController: UIViewController {
    
    var presenter: MarketTickerPageContentPresenter!
    @IBOutlet private weak var testLabel: UILabel!
    
    fileprivate(set) var viewModel: MarketTickerPageContentViewControllerViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadMarketTickerPageContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - MarketTickerPageContentScreen

extension MarketTickerPageContentViewController: MarketTickerPageContentScreen {
    
    func configureMarketTickerPageContent(viewModel: MarketTickerPageContentViewControllerViewModel) {
        self.viewModel = viewModel
        
        testLabel.text = "\(viewModel.pageIndex)"
    }
    
}
