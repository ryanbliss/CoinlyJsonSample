//
//  FirstViewControllerViewModel.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class FirstViewControllerViewModel {
    var base: Base?
    var endpoint = "testy"
    
    func getBackgroundColor() -> UIColor {
        return ColorHelper.hexStringToUIColor(hex: base!.page.backgroundColor)
    }
    func getPrimaryColor() -> UIColor {
        return ColorHelper.hexStringToUIColor(hex: base!.page.primaryColor)
    }
    
    func getNumSections() -> Int {
        return base!.sections.count
    }
    
    func getNibs() -> [String: UINib] {
        let nibs: [String: UINib] = CellCreateManager().getCellTypes(for: base!.sections)
        return nibs
    }
    
    func getReuseIdentifier(for indexPath: IndexPath) -> String {
        return base!.sections[indexPath.section].type
    }
    
    func getCellData(for indexPath: IndexPath) -> Section {
        return base!.sections[indexPath.section]
    }
    
    func shouldShowNavBar() -> Bool {
        return base!.page.navBarIsHidden
    }
    
    func getNavTitle() -> String {
        guard let title = base?.navigationBar?.center.title else { return "" }
        return title
    }
    
    func getCenterNavEndpoint() -> String? {
        return base?.navigationBar?.center.link.nextEndpoint
    }
    
    func getFooter() -> Footer? {
        return base?.footer
    }
}
