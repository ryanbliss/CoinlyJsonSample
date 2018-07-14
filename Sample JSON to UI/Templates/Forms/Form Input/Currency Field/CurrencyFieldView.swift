//
//  DropdownField.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CurrencyFieldView: FieldInputView, UIGestureRecognizerDelegate {
    
    override var data: FormRow? {
        didSet {
            guard let field = data?.currencyField else { return }
            fieldData = field
        }
    }
    var fieldData: CurrencyField? {
        didSet {
            setupLabels()
            setupTextFields()
        }
    }

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var iconDescription: UILabel!
    @IBOutlet var icon: UIImageView!
    
    override func setup() {
        self.fieldValidator = CurrencyFieldValidation()
        setupTap()
    }
    
    func setupLabels() {
        guard let field = fieldData else { return }
        label.text = field.label
        textField.text = field.text
        iconDescription.text = field.currencyOption.text
    }
    
    func setupTextFields() {
        textField.addTarget(self, action: #selector(formDidChange), for: .editingChanged)
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
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
        fieldData?.text = newText
        data?.currencyField = fieldData
        delegate?.changedInput(for: data!)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let options = fieldData!.currencyOptions
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        actionSheetController.addAction(cancelActionButton)
        
        for option in options {
            let button = UIAlertAction(title: option.text, style: .default)
            { _ in
                self.data?.currencyField?.currencyOption = option
                var text = self.data!.currencyField!.text
                if self.data!.currencyField!.currencyOption.symbol != "" {
                    text.remove(at: text.startIndex)
                }
                self.data?.currencyField?.text = (self.data?.currencyField?.currencyOption.symbol)! + text
                self.delegate?.changedInput(for: self.data!)
            }
            actionSheetController.addAction(button)
        }
        
        let notification = Notification(name: Notification.Name(rawValue: "presentController"), object: nil, userInfo: ["controller": actionSheetController])
        NotificationCenter.default.post(notification)
    }
}
