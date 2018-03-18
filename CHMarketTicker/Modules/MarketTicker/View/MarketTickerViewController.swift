//
//  MarketTickerViewController.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit
import Starscream

protocol MarketTickerScreen: class {
    func configureMarketTicker(viewModel: MarketTickerViewControllerViewModel)
}

class MarketTickerViewController: UIViewController {
    
    var presenter: MarketTickerPresenter!
    
    fileprivate var viewModel: MarketTickerViewControllerViewModel!
    
    fileprivate var socket = WebSocket(url: URL(string: "wss://feed.cobinhood.com/ws")!)
    
    @IBOutlet private weak var segmentBackgroundView: UIView!
    @IBOutlet private weak var pageViewControllerBackgroundView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadMarketTicker()
        
        configureLayout()
        
        socket.delegate = self
        socket.connect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
    // MARK: - Private
    
    private func configureLayout() {
        let marketTickerPageViewController = MarketTickerPageDefaultBuilder().buildMarketTickerPageModule()
        UIView.addSubViewConstraints(to: pageViewControllerBackgroundView, subView: marketTickerPageViewController.view)
    }
    
}

// MARK: - MarketTickerScreen

extension MarketTickerViewController: MarketTickerScreen {
    
    func configureMarketTicker(viewModel: MarketTickerViewControllerViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - WebSocketDelegate

extension MarketTickerViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocketDidDisconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocketDidReceiveData")
    }
    
}
