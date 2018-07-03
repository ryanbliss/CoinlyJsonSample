//
//  SectionHeaderView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardHeaderView: GenericCardView {
    
    override var data: CardRow? {
        didSet {
            guard let data = data else {
                return
            }
            guard let header = data.sectionHeader else {
                return
            }
            sectionHeader = header
        }
    }
    var sectionHeader: SectionHeader? {
        didSet {
            setupTitle()
            setupButton()
        }
    }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var button: UIButton!
    @IBAction func pressButton(_ sender: Any) {
        buttonDelegate?.pressedButton(with: sectionHeader!.button.link.nextEndpoint)
    }
    
    func setupTitle() {
        let label = sectionHeader!.label
        self.title.text = label.text
        self.title.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.title.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    
    func setupButton() {
        let buttonData = sectionHeader!.button
        button.setTitle(buttonData.text, for: .normal)
        button.setTitleColor(ColorHelper.hexStringToUIColor(hex: buttonData.attributes.color), for: .normal)
        button.titleLabel?.font =  UIFont(name: buttonData.attributes.font, size: CGFloat(buttonData.attributes.fontSize))
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
