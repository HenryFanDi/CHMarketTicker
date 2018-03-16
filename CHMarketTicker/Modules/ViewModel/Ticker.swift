//
//  Ticker.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct Ticker: Codable {
    
    var tradingPairId: String
    var timestamp: Int
    var highOf24h: String
    var lowOf24h: String
    var openOf24h: String
    var volumeOf24h: String
    var lastTradePrice: String
    var highestBid: String
    var lowestAsk: String
    
    enum CodingKeys: String, CodingKey {
        case tradingPairId = "trading_pair_id"
        case timestamp = "timestamp"
        case highOf24h = "24h_high"
        case lowOf24h = "24h_low"
        case openOf24h = "24h_open"
        case volumeOf24h = "24h_volume"
        case lastTradePrice = "last_trade_price"
        case highestBid = "highest_bid"
        case lowestAsk = "lowest_ask"
    }
    
}
