//
//  UpdateData.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

protocol UpdateDelegate {
    func update(for newData: Any)
}

extension FirstViewController: UpdateDelegate {
    func update(for newData: Any) {
        if let newSection = newData as? Section {
            guard let sections = viewModel.base?.sections else { return }
            var newSections: [Section] = []
            for section in sections {
                if section.type == newSection.type {
                    newSections.append(newSection)
                } else {
                    newSections.append(section)
                }
            }
            viewModel.base?.sections = newSections
        }
    }
}
