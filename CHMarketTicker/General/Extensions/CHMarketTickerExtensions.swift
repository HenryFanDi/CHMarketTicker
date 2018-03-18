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
    
    class func loadFromNib(ownerOrNil: AnyObject?) -> UIView? {
        let nibObjects = nib.instantiate(withOwner: ownerOrNil, options: nil)
        return nibObjects[0] as? UIView
    }
    
    class func addSubViewConstraints(to targetView: UIView, subView: UIView) {
        for subview in targetView.subviews {
            subview.removeFromSuperview()
        }
        
        targetView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let metrics = [
            "padding": 0
        ]
        
        let views: [String: UIView] = [
            "subView": subView
        ]
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[subView]-padding-|",
                                                         options: NSLayoutFormatOptions(),
                                                         metrics: metrics,
                                                         views: views)
        targetView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[subView]-padding-|",
                                                     options: NSLayoutFormatOptions(),
                                                     metrics: metrics,
                                                     views: views)
        targetView.addConstraints(constraints)
    }
    
}

// MARK: - UIViewController

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

// MARK: - Notification

extension Notification.Name {
    
    static let didReceiveTickerUpdate = Notification.Name("didReceiveTickerUpdate")
    static let didReceiveTickerUpdateUpdateLayout = Notification.Name("didReceiveTickerUpdateUpdateLayout")
    
}
