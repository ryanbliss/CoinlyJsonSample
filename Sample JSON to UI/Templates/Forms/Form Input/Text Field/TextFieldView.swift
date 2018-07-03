//
//  TextField.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class TextFieldView: FieldInputView {
    
    override var data: FormRow? {
        didSet {
            guard let field = data?.textField else { return }
            fieldData = field
        }
    }
    var fieldData: TextField? {
        didSet {
            setupLabels()
            setValidation()
        }
    }

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func setup() {
        setupTextFields()
    }
    
    func setupLabels() {
        guard let field = fieldData else { return }
        label.text = field.label
        textField.text = field.text
    }
    
    func setupTextFields() {
        textField.addTarget(self, action: #selector(formDidChange), for: .editingChanged)
    }
    
    func setValidation() {
        guard let type = fieldData?.type else { return }
        if type == "double" {
            self.fieldValidator = DoubleFieldValidation()
        }
    }
    
    @objc func formDidChange(sender: UITextField) {
        guard let _ = fieldData else { return }
        self.fieldValidator?.updateText(for: sender.text!, with: data) { (error, replacement) in
            if error != nil {
                let notification = Notification(name: Notification.Name(rawValue: "presentController"), object: nil, userInfo: ["controller": error!])
                NotificationCenter.default.post(notification)
            }
            if replacement != nil {
                sender.text = replacement
            }
        }
        let newText = sender.text!
        data?.textField?.text = newText
        delegate?.changedInput(for: data!)
    }
}
