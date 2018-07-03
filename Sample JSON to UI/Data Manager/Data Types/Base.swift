//
//  Base.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

struct Base: Codable {
    let page: Page
    let navigationBar: NavigationBar?
    let footer: Footer?
    var sections: [Section]
}

struct Page: Codable {
    let title, primaryColor, backgroundColor, currentEndpoint: String
    let lastEndpoint: String
    let navBarIsHidden: Bool
}

struct NavigationBar: Codable {
    let theme: String
    let center: Center
}

struct Footer: Codable {
    let theme: String
    let cancelButton: CancelButton
    let submitButton: SubmitButton
}

struct Section: Codable {
    let type: String
    let header: Header?
    let sectionHeader: SectionHeader?
    var card: Card?
}

struct Value: Codable {
    let labels: [Label]
}



