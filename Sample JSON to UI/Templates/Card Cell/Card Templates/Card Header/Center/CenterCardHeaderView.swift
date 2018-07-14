//
//  SectionHeaderView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CenterCardHeaderView: GenericCardView {
    
    override var data: CardRow? {
        didSet {
            guard let data = data else {
                return
            }
            guard let header = data.sectionHeaderCenter else {
                return
            }
            sectionHeader = header
        }
    }
    var sectionHeader: SectionHeaderCenter? {
        didSet {
            setupTitle()
        }
    }
    
    @IBOutlet var title: UILabel!
    
    func setupTitle() {
        let label = sectionHeader!.label
        self.title.text = label.text
        self.title.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.title.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
