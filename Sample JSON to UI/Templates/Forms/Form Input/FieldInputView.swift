//
//  FieldInputView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class FieldInputView: UIView {
    var data: FormRow?
    var fieldValidator: FieldInputValidation?
    var delegate: FieldInputDelegate?
    func setup() {
        // Do nothing...use in subclasses
    }
}
