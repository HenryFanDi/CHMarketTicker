//
//  TickerUpdateResponse.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct TickerUpdateResponse: Serializable {
    
    var channelId: String
    var update: [String]
    
    enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case update = "update"
    }
    
}
