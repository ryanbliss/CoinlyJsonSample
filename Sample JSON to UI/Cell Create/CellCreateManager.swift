//
//  CellCreateManager.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

protocol CreateCell {
    func createCell(for cell: GenericTableViewCell) -> GenericTableViewCell
}

class CellCreateManager {
    
    func getCellTypes(for sections: [Section]) -> [String: UINib] {
        let nibs = BaseNibsCreator().get(for: sections)
        return nibs
    }
    
    func getCardViewTypes(for rows: [CardRow]) -> [GenericCardView] {
        let views = CardViewsCreator().get(for: rows)
        return views
    }
    
    func getFormViewTypes(for rows: [FormRow]) -> [FieldInputView] {
        let views = FormViewsCreator().get(for: rows)
        return views
    }
}
