//
//  footerView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class FooterView: UIView {
    var delegate: FooterDelegate?
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBAction func leftButtonAction(_ sender: Any) {
        delegate?.left()
    }
    @IBAction func rightButtonAction(_ sender: Any) {
        delegate?.right()
    }
}
