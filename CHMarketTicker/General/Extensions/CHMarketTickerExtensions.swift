//
//  CHMarketTickerExtensions.swift
//  CHMarketTicker
//
//  Created by HenryFan on 16/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

// MARK: - UIView

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

// MARK: - UIViewController

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
