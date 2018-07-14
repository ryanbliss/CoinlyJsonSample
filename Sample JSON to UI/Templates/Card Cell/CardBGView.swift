//
//  CardBGView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardBGView: UIView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 24.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 1.0 {
        didSet {
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOpacity: Float = 1.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable
    var shadowColor: UIColor = UIColor.black {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
