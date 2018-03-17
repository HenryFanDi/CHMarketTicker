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
    
    fileprivate(set) var viewModel: MarketTickerPageContentViewControllerViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadMarketTickerPageContent()
        
        configureLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private
    
    private func configureLayout() {
        tableView.register(MarketTickerPageContentTableViewCell.nib, forCellReuseIdentifier: MarketTickerPageContentTableViewCell.identifier)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}

// MARK: - MarketTickerPageContentScreen

extension MarketTickerPageContentViewController: MarketTickerPageContentScreen {
    
    func configureMarketTickerPageContent(viewModel: MarketTickerPageContentViewControllerViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - UITableViewDelegate

extension MarketTickerPageContentViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension MarketTickerPageContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketTickerPageContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: MarketTickerPageContentTableViewCell.identifier, for: indexPath) as! MarketTickerPageContentTableViewCell
        marketTickerPageContentTableViewCell.configure(viewModel: viewModel.cellViewModels[indexPath.row])
        return marketTickerPageContentTableViewCell
    }
    
}
