//
//  MarketTickerViewController.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit
import Starscream
import JGProgressHUD

protocol MarketTickerScreen: class {
    func configureMarketTicker(viewModel: MarketTickerViewControllerViewModel)
}

class MarketTickerViewController: UIViewController {
    
    var presenter: MarketTickerPresenter!
    
    fileprivate var viewModel: MarketTickerViewControllerViewModel!
    
    fileprivate var socket = WebSocket(url: URL(string: "wss://feed.cobinhood.com/ws")!)
    
    fileprivate let hudProgress = JGProgressHUD(style: .dark)
    
    @IBOutlet fileprivate weak var segmentBackgroundView: UIView!
    @IBOutlet private weak var pageViewControllerBackgroundView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pairs"
        
        presenter.loadMarketTicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hudProgress.isVisible {
            hudProgress.show(in: view, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
}

// MARK: - MarketTickerScreen

extension MarketTickerViewController: MarketTickerScreen {
    
    func configureMarketTicker(viewModel: MarketTickerViewControllerViewModel) {
        self.viewModel = viewModel
        
        if hudProgress.isVisible {
            hudProgress.dismiss(animated: true)
        }
        
        configureSocket()
        configureLayout()
    }
    
    private func configureSocket() {
        socket.delegate = self
        socket.connect()
        
        let task = TaskTimerManager.shared.createTaskTimer(repeatingInterval: 30) { [unowned self] () in
            self.socket.connect()
        }
        TaskTimerManager.shared.startTaskTimer(task: task)
    }
    
    private func configureLayout() {
        addSegmentViews()
        
        let marketTickerPageViewController = MarketTickerPageDefaultBuilder().buildMarketTickerPageModule(tickerViewModels: viewModel.tickerViewModels)
        UIView.addSubViewConstraints(to: pageViewControllerBackgroundView, subView: marketTickerPageViewController.view)
    }
    
}

// MARK: - WebSocketDelegate

extension MarketTickerViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocketDidConnect")
        
        viewModel.subscribeTickers().forEach { (jsonString) in
            socket.write(string: jsonString)
        }
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        viewModel.updateTickersAfterSubscribed(responseString: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    }
    
}

// MARK: - Segment

extension MarketTickerViewController {
    
    fileprivate func addSegmentViews() {
        segmentBackgroundView.subviews.forEach{ $0.removeFromSuperview() }
        
        var items = [SegmentView]()
        for (_, pairCurrency) in viewModel.pairCurrencies.enumerated() {
            let segmentView = SegmentView.initWithNib()
            segmentView.configure(pairCurrency: pairCurrency)
            segmentBackgroundView.addSubview(segmentView)
            items.append(segmentView)
        }
        addSegmentBackgroundViewConstraints(items: items)
    }
    
    fileprivate func addSegmentBackgroundViewConstraints(items: [SegmentView]) {
        let numberOfItems = items.count
        let itemWidth = UIScreen.main.bounds.width / CGFloat(numberOfItems)
        let metrics = [
            "padding": 0,
            "itemWidth": itemWidth
        ]
        
        for var index in 0..<numberOfItems {
            var followingsItem = SegmentView()
            let item = items[index]
            item.translatesAutoresizingMaskIntoConstraints = false
            
            if index > 0, index < numberOfItems - 1 {
                followingsItem = items[index - 1]
            }
            
            if index == 0 {
                segmentBackgroundView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[item(itemWidth)]",
                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                   metrics: metrics,
                                                   views: ["item": item]))
            } else if index == numberOfItems - 1 {
                segmentBackgroundView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat: "H:[item(itemWidth)]-padding-|",
                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                   metrics: metrics,
                                                   views: ["item": item]))
            } else {
                segmentBackgroundView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat: "H:[followingsItem]-padding-[item(==followingsItem)]",
                                                   options: NSLayoutFormatOptions(rawValue: 0),
                                                   metrics: metrics,
                                                   views: ["followingsItem": followingsItem, "item": item]))
            }
            segmentBackgroundView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[item]-padding-|",
                                               options: NSLayoutFormatOptions(rawValue: 0),
                                               metrics: metrics,
                                               views: ["item": item]))
            index += 1
        }
    }
    
}
