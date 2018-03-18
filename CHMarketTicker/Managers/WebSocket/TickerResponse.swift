//
//  TickerResponse.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct TickerResponse: Serializable {
    
    var event: String
    var type: String
    var channelId: String
    var tradingPairId: String
    
    enum CodingKeys: String, CodingKey {
        case event = "event"
        case type = "type"
        case channelId = "channel_id"
        case tradingPairId = "trading_pair_id"
    }    
    
}
