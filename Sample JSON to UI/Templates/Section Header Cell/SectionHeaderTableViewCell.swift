//
//  SectionHeaderTableViewCell.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: GenericTableViewCell {
    
    override var data: Section? {
        didSet {
            sectionHeader = data!.sectionHeader!
        }
    }
    var sectionHeader: SectionHeader? {
        didSet {
            setupButton()
            setupTitle()
        }
    }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var button: UIButton!
    
    @IBAction func pressedButton(_ sender: Any) {
        self.buttonDelegate?.pressedButton(with: sectionHeader!.button.link.nextEndpoint)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
