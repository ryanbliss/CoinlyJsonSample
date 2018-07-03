//
//  DoubleFieldValidatiton.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/11/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class DoubleFieldValidation: FieldInputValidation {
    func updateText(for text: String, with data: FormRow?, completion: @escaping (_ error: UIAlertController?, _ replacementText: String?) -> ()) {
        //TODO: handling if people have more than one decimal
        guard let coinsString = data?.textField?.text else {
            return
        }
        guard let coins = Double(coinsString) else { return }
        print(coinsString)
        if coins > 999999999.99 {
            let alert = AlertHelper.createBasicAlert("Bruh, this isn't even technically possible.", message: "Please enter a number 999999999.99 or lower.")
            completion(alert, "\(999999999.99)")
        } else {
            completion(nil,nil)
        }
    }
}
