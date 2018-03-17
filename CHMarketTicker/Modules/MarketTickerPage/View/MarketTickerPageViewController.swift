//
//  MarketTickerPageViewController.swift
//  CHMarketTicker
//
//  Created by HenryFan on 17/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol MarketTickerPageScreen: class {
    func configureMarketTickerPage(viewModel: MarketTickerPageViewControllerViewModel)
}

class MarketTickerPageViewController: UIPageViewController {
    
    var presenter: MarketTickerPagePresenter!
    
    fileprivate var viewModel: MarketTickerPageViewControllerViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - MarketTickerPageScreen

extension MarketTickerPageViewController: MarketTickerPageScreen {
    
    func configureMarketTickerPage(viewModel: MarketTickerPageViewControllerViewModel) {
        self.viewModel = viewModel
    }
    
}
