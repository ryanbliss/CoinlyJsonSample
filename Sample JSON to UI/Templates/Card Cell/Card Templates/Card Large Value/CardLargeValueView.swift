//
//  CardLargeValueView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardLargeValueView: GenericCardView {
    override var data: CardRow? {
        didSet {
            guard let data = data else {
                return
            }
            labels = data.cardLargeValue
        }
    }
    var labels: [Label]? {
        didSet {
            guard let _ = labels else {
                return
            }
            setupTitle()
            setupValue()
            setupSubValue()
        }
    }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var value: UILabel!
    @IBOutlet var subValue: UILabel!
    
    func setupTitle() {
        let label = labels![0]
        self.title.text = label.text
        self.title.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.title.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    func setupValue() {
        let label = labels![1]
        self.value.text = label.text
        self.value.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.value.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    func setupSubValue() {
        let label = labels![2]
        self.subValue.text = label.text
        self.subValue.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.subValue.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }

}
