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
        
        presenter.loadMarketTickerPage()
        
        delegate = self
        dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - MarketTickerPageScreen

extension MarketTickerPageViewController: MarketTickerPageScreen {
    
    func configureMarketTickerPage(viewModel: MarketTickerPageViewControllerViewModel) {
        self.viewModel = viewModel
        
        let marketTickerPageContentViewController = viewModel.marketTickerPageContentViewControllers[0]
        setViewControllers([marketTickerPageContentViewController], direction: .forward, animated: true, completion: nil)
    }
    
}

// MARK: - UIPageViewControllerDelegate

extension MarketTickerPageViewController: UIPageViewControllerDelegate {
    
}

// MARK: - UIPageViewControllerDataSource

extension MarketTickerPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let marketTickerPageContentViewController = viewController as? MarketTickerPageContentViewController {
            var pageIndex = marketTickerPageContentViewController.viewModel.pageIndex
            if pageIndex == 0 || pageIndex == NSNotFound {
                return nil
            }
            pageIndex -= 1
            
            return viewModel.marketTickerPageContentViewControllers[pageIndex]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let marketTickerPageContentViewController = viewController as? MarketTickerPageContentViewController {
            var pageIndex = marketTickerPageContentViewController.viewModel.pageIndex
            if pageIndex == NSNotFound {
                return nil
            }
            pageIndex += 1
            
            if pageIndex == viewModel.marketTickerPageContentViewControllers.count {
                return nil
            }
            
            return viewModel.marketTickerPageContentViewControllers[pageIndex]
        }
        return nil
    }
    
}
