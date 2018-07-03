//
//  FormViewsCreator.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class FormViewsCreator {
    enum FormRowTypes: String {
        case dropdown = "dropdownField"
        case currency = "currencyField"
        case textField = "textField"
        case dateAndTime = "dateAndTimeField"
    }
    func get(for rows: [FormRow]) -> [FieldInputView] {
        var views: [FieldInputView] = []
        for row in rows {
            let data = FormRowTypes(rawValue: row.type)
            guard let type = data else {
                continue
            }
            switch type {
            case .dropdown:
                guard let _ = row.dropdownField else { continue }
                let view = UINib(nibName: "DropdownFieldView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DropdownFieldView
                view.data = row
                views.append(view)
            case .currency:
                guard let _ = row.currencyField else { continue }
                let view = UINib(nibName: "CurrencyFieldView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CurrencyFieldView
                view.data = row
                views.append(view)
            case .textField:
                guard let _ = row.textField else { continue }
                let view = UINib(nibName: "TextFieldView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TextFieldView
                view.data = row
                views.append(view)
            case .dateAndTime:
                guard let _ = row.dateAndTimeField else { continue }
                let view = UINib(nibName: "DateTimeFieldView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DateTimeFieldView
                view.data = row
                views.append(view)
            }
        }
        return views
    }
}
