//
//  GenericView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class GenericCardView: UIView {
    
    var data: CardRow?
    var buttonDelegate: ButtonAction?
    var updateDelegate: UpdateDelegate?
    
    func update(for newData: CardRow) {
        data = newData
    }
}
