//
//  SegmentView.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

class SegmentView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bottomLine: UIView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func initWithNib() -> SegmentView {
        return UIView.loadNibNamed(name: String(describing: SegmentView.self), owner: nil) as! SegmentView
    }
    
    // MARK: - Private
    
    // MARK: - Public
    
    func configure(pairCurrency: String) {
        titleLabel.text = pairCurrency
    }
    
}
