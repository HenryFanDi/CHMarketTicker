//
//  Serializable.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

protocol Serializable: Codable {
    func encode() -> Data?
}

extension Serializable {
    
    func encode() -> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(self)
    }
    
}
