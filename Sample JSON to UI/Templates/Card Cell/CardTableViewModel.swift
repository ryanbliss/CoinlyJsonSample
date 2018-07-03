//
//  CardTableViewModel.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardTableViewModel {
    var card: Card?
    
    func getNumRows() -> Int {
        return card!.cardRows.count
    }
    
    func getViews() -> [GenericCardView] {
        let views = CellCreateManager().getCardViewTypes(for: card!.cardRows)
        
        return views
    }
    
    func getReuseIdentifier(for indexPath: IndexPath) -> String {
        return card!.cardRows[indexPath.section].type
    }
    
    func getCellData(for indexPath: IndexPath) -> CardRow {
        return card!.cardRows[indexPath.section]
    }
    
    
    
}
