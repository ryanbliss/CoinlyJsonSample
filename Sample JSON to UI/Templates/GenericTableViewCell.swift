//
//  GenericTableViewCell.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/11/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell {
    var data: Section?
    var buttonDelegate: ButtonAction?
    var updateDelegate: UpdateDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    func setup() {
        // Do nothing, override in subclasses
    }
}
