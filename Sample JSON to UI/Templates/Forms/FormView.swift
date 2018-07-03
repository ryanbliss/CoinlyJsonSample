//
//  FormView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

protocol FieldInputDelegate {
    func changedInput(for row: FormRow)
}

class FormView: GenericCardView, FieldInputDelegate {

    @IBOutlet var stackView: UIStackView!
    
    override var data: CardRow? {
        didSet {
            guard let data = data else {
                return
            }
            guard let formData = data.form else {
                return
            }
            form = formData
        }
    }
    var form: Form? {
        didSet {
            if stackView.arrangedSubviews.count == 0 {
                setupStackView()
            }
        }
    }
    
    func setupStackView() {
        guard let rows = form?.formRows else { return }
        let views = CellCreateManager().getFormViewTypes(for: rows)
        for view in views {
            view.delegate = self
            view.setup()
            stackView.addArrangedSubview(view)
        }
    }
    
    // MARK: FieldInputDelegate Methods
    
    func changedInput(for row: FormRow) {
        guard let form = data?.form else { return }
        var newRows: [FormRow] = []
        for formRow in form.formRows {
            if formRow.id == row.id {
                newRows.append(row)
                print(row)
            } else {
                newRows.append(formRow)
            }
        }
        data?.form?.formRows = newRows
        updateDelegate?.update(for: data!)
    }
}
