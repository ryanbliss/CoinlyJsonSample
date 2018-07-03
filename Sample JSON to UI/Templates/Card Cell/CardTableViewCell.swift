//
//  CardTableViewCell.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardTableViewCell: GenericTableViewCell, ButtonAction, UpdateDelegate {
    
    override var data: Section? {
        didSet {
            guard let data = data?.card else {
                return
            }
            viewModel.card = data
        }
    }
    
    override func setup() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
        }
        for view in viewModel.getViews() {
            view.buttonDelegate = self
            view.updateDelegate = self
            stackView.addArrangedSubview(view)
        }
    }
    
    func pressedButton(with endpoint: String) {
        buttonDelegate?.pressedButton(with: endpoint)
    }
    
    var viewModel = CardTableViewModel()
    
    @IBOutlet var card: UIView!
    @IBOutlet var stackView: UIStackView!
    
    func update(for newData: Any) {
        if let newRow = newData as? CardRow {
            guard let rows = viewModel.card?.cardRows else { return }
            var newRows: [CardRow] = []
            for row in rows {
                if row.type == newRow.type {
                    newRows.append(newRow)
                } else {
                    newRows.append(row)
                }
            }
            data?.card?.cardRows = newRows
            updateDelegate?.update(for: data!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        card.layer.shadowPath = UIBezierPath(rect: card.bounds).cgPath
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
