//
//  FieldInputViewModel.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

protocol FieldInputValidation {
    func updateText(for text: String, with data: FormRow?, completion: @escaping (_ error: UIAlertController?, _ replacementText: String?) -> ())
}
