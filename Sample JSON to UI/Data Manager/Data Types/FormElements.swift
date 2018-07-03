//
//  FormElements.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/28/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

struct DropdownField: Codable {
    let label, placeholder: String
    var text: String
    let options: [Option]
}

struct Option: Codable {
    var text: String
    let reloadEndpoint: String?
}

struct CurrencyField: Codable {
    let label, placeholder: String
    var text: String
    var currencyOption: CurrencyOption
    let currencyOptions: [CurrencyOption]
}

struct CurrencyOption: Codable {
    let text, symbol: String
}

struct TextField: Codable {
    let type, label, placeholder: String
    var text: String
}

struct DateAndTimeField: Codable {
    let label, placeholder, pickerMethod, restriction: String
    var timestamp: Int
}
