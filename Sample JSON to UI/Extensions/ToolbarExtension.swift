//
//  ToolbarExtension.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

extension UIToolbar {
    
    func ToolbarDateAhdTimePicker(doneSelect : Selector, toggleSelect: Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
        let continueButton = UIBarButtonItem(title: "Switch Mode", style: .plain, target: self, action: toggleSelect)
        let doneButton = UIBarButtonItem(title: "DONE", style: .done, target: self, action: doneSelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([continueButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    func ToolbarDateOrTimePicker(doneSelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "DONE", style: .done, target: self, action: doneSelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
