//
//  DropdownField.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class DropdownFieldView: FieldInputView, UIGestureRecognizerDelegate {
    
    override var data: FormRow? {
        didSet {
            guard let field = data?.dropdownField else { return }
            fieldData = field
        }
    }
    var fieldData: DropdownField? {
        didSet {
            setupLabels()
        }
    }

    @IBOutlet var label: UILabel!
    @IBOutlet var selected: UILabel!
    @IBOutlet var icon: UIImageView!
    
    override func setup() {
        setupTap()
    }
    
    func setupLabels() {
        guard let field = fieldData else { return }
        label.text = field.label
        selected.text = field.text
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        guard let options = fieldData?.options else { return }
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        for option in options {
            let button = UIAlertAction(title: option.text, style: .default)
            { _ in
//                self.fieldData!.text = option.text
                self.data?.dropdownField?.text = option.text
                self.delegate?.changedInput(for: self.data!)
                
                if option.reloadEndpoint != nil {
                    let notification = Notification(name: Notification.Name(rawValue: "reloadPage"), object: nil, userInfo: ["endpoint": option.reloadEndpoint!])
                    NotificationCenter.default.post(notification)
                }
            }
            actionSheetController.addAction(button)
        }
        
        let notification = Notification(name: Notification.Name(rawValue: "presentController"), object: nil, userInfo: ["controller": actionSheetController])
        NotificationCenter.default.post(notification)
    }
}
