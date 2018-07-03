//
//  BaseCells.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class BaseNibsCreator {
    enum CellTypes: String {
        case header = "header"
        case sectionHeader = "sectionHeader"
        case card = "card"
    }
    
    func get(for sections: [Section]) -> [String: UINib] {
        var nibs: [String: UINib] = [:]
        
        for section in sections {
            let data = CellTypes(rawValue: section.type)
            guard let type = data else {
                continue
            }
            switch type {
            case .header:
                guard let _ = section.header else { continue }
                nibs[section.type] = UINib(nibName: String(describing: HeaderTableViewCell.self), bundle: nil)
            case .sectionHeader:
                guard let _ = section.sectionHeader else { continue }
                nibs[section.type] = UINib(nibName: String(describing: SectionHeaderTableViewCell.self), bundle: nil)
            case .card:
                guard let _ = section.card else { continue }
                nibs[section.type] = UINib(nibName: String(describing: CardTableViewCell.self), bundle: nil)
            }
            
        }
        return nibs
    }
}
