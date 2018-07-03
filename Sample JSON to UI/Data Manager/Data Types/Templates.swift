//
//  Templates.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/11/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

struct Header: Codable {
    let theme: String
    let labels: [Label]
    let values: [Value]
}

struct SectionHeader: Codable {
    let label: Label
    let button: Button
}

struct SectionHeaderCenter: Codable {
    let label: Label
}

struct Card: Codable {
    var cardRows: [CardRow]
}

struct CardRow: Codable {
    let type: String
    let sectionHeader: SectionHeader?
    let sectionHeaderCenter: SectionHeaderCenter?
    let cardLargeValue: [Label]?
    let cardCollectionValues: [Value]?
    var form: Form?
}

struct CardHeader: Codable {
    let label: Label
    let button: Button
}

struct Form: Codable {
    var formRows: [FormRow]
}

struct FormRow: Codable {
    let type: String
    let id: String
    var dropdownField: DropdownField?
    var currencyField: CurrencyField?
    var textField: TextField?
    var dateAndTimeField: DateAndTimeField?
}
