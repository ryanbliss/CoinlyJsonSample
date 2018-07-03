//
//  DropdownFieldViewModel.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CurrencyFieldValidation: FieldInputValidation {
    func updateText(for text: String, with data: FormRow?, completion: @escaping (_ error: UIAlertController?, _ replacementText: String?) -> ()) {
        //TODO: handling if people have more than one decimal
        guard let currencyCode = data?.currencyField?.currencyOption.symbol else { return }
        if text != currencyCode && text != "" {
            var containsCurrencyCode = false
            if currencyCode != "" {
                containsCurrencyCode = text.contains(currencyCode)
            }
            var tempString = text
            if containsCurrencyCode {
                tempString.remove(at: tempString.startIndex)
            }
            guard let cost = Double(tempString) else {
                let alert = AlertHelper.createBasicAlert("Oops! Something went wrong.", message: "Something went wrong when updating your currency field.")
                completion(alert, nil)
                return
            }
            if cost > 999999999.99 {
                let alert = AlertHelper.createBasicAlert("You don't have that much money, come on now...", message: "Please enter a number \(currencyCode)999999999.99 or lower.")
                completion(alert, "\(currencyCode)999999999.99")
            } else {
                if !containsCurrencyCode && currencyCode != "" {
                    completion(nil, "\(currencyCode)\(Int(cost))")
                } else {
                    completion(nil, nil)
                }
            }
        } else {
            completion(nil, nil)
        }
    }
}
