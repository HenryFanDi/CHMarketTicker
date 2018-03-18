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
