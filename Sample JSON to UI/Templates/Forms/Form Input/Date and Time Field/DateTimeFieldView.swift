//
//  DropdownField.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class DateTimeFieldView: FieldInputView, UIGestureRecognizerDelegate {
    
    override var data: FormRow? {
        didSet {
            guard var field = data?.dateAndTimeField else { return }
            if field.timestamp == 0 {
                field.timestamp = Int(Date().timeIntervalSince1970)
            }
            fieldData = field
        }
    }
    var fieldData: DateAndTimeField? {
        didSet {
            setupLabels()
        }
    }

    @IBOutlet var label: UILabel!
    @IBOutlet var textInput: UITextField!
    @IBOutlet var icon: UIImageView!
    
    override func setup() {
        setupTap()
        setupDatePicker()
    }
    
    func setupLabels() {
        guard let field = fieldData else { return }
        label.text = field.label
        
        textInput.text = DateTimeHelper().convertToString(for: field.timestamp, includeTime: true)
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    let datePickerView = UIDatePicker()
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

//        let notification = Notification(name: Notification.Name(rawValue: "presentController"), object: nil, userInfo: ["controller": actionSheetController])
//        NotificationCenter.default.post(notification)
    }
    
    func setupDatePicker() {
        datePickerView.datePickerMode = UIDatePickerMode.date
        textInput.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        var toolBar = UIToolbar()
        if fieldData?.pickerMethod == "dateAndTime" {
            toolBar = UIToolbar().ToolbarDateAhdTimePicker(doneSelect: #selector(dismissPicker), toggleSelect: #selector(switchMode))
            datePickerView.datePickerMode = .dateAndTime
        } else if fieldData?.pickerMethod == "date" || fieldData?.pickerMethod == "time" {
            toolBar = UIToolbar().ToolbarDateOrTimePicker(doneSelect: #selector(dismissPicker))
            if fieldData?.pickerMethod == "time" {
                datePickerView.datePickerMode = .time
            }
        }
        
        textInput.inputAccessoryView = toolBar
        if fieldData?.restriction == "cannotBeInFuture" {
            datePickerView.maximumDate = Date()
        } else if fieldData?.restriction == "cannotBeInPast" {
            datePickerView.minimumDate = Date()
        }
        
    }
    
    @objc func dismissPicker() {
        textInput.resignFirstResponder()
    }
    
    @objc func switchMode() {
        if datePickerView.datePickerMode == .dateAndTime {
            datePickerView.datePickerMode = .date
        } else if datePickerView.datePickerMode == .date {
            datePickerView.datePickerMode = .dateAndTime
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        //TODO: Change date label
        data?.dateAndTimeField?.timestamp = Int(sender.date.timeIntervalSince1970)
        delegate?.changedInput(for: data!)
    }
}
