//
//  TickerRequest.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

struct TickerRequest: Serializable {
    
    var action: String = "subscribe"
    var type: String = "ticker"
    var tradingPairId: String
    
    enum CodingKeys: String, CodingKey {
        case action = "action"
        case type = "type"
        case tradingPairId = "trading_pair_id"
    }
    
}

extension TickerRequest {
    
    init(tradingPairId: String) {
        self.tradingPairId = tradingPairId
    }
    
}

class TickerRequestBuilder {
    
    func build(tradingPairId: String) -> TickerRequest {
        return TickerRequest(tradingPairId: tradingPairId)
    }
    
}

// MARK: - Decodable

extension TickerRequest: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        action = try values.decode(String.self, forKey: .action)
        type = try values.decode(String.self, forKey: .type)
        tradingPairId = try values.decode(String.self, forKey: .tradingPairId)
    }
    
}
