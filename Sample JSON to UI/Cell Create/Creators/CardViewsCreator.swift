//
//  CardCreateManager.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardViewsCreator {
    enum CardRowTypes: String {
        case cardHeader = "sectionHeader"
        case cardHeaderCenter = "sectionHeaderCenter"
        case cardLargeValue = "cardLargeValue"
        case cardCollectionValues = "cardCollectionValues"
        case form = "form"
    }
    func get(for rows: [CardRow]) -> [GenericCardView] {
        var views: [GenericCardView] = []
        for row in rows {
            let data = CardRowTypes(rawValue: row.type)
            guard let type = data else {
                continue
            }
            switch type {
            case .cardHeader:
                guard let _ = row.sectionHeader else { continue }
                let view = UINib(nibName: "CardHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardHeaderView
                view.data = row
                views.append(view)
            case .cardHeaderCenter:
                guard let _ = row.sectionHeaderCenter else { continue }
                let view = UINib(nibName: "CenterCardHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CenterCardHeaderView
                view.data = row
                views.append(view)
            case .cardLargeValue:
                guard let _ = row.cardLargeValue else { continue }
                let view = UINib(nibName: "CardLargeValueView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardLargeValueView
                view.data = row
                views.append(view)
            case .cardCollectionValues:
                guard let _ = row.cardCollectionValues else { continue }
                let view = UINib(nibName: "CardCollectionValuesView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardCollectionValuesView
                view.data = row
                views.append(view)
            case .form:
                guard let _ = row.form else { continue }
                let view = UINib(nibName: "FormView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FormView
                view.data = row
                views.append(view)
            }
        }
        return views
    }
}
