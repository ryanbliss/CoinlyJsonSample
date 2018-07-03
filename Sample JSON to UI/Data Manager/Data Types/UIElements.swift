//
//  UIElements.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

struct Label: Codable {
    let name, text: String
    let attributes: Attributes
}

struct Center: Codable {
    let title: String
    let link: Link
}

struct Button: Codable {
    let text: String
    let attributes: Attributes
    let link: Link
}

struct CancelButton: Codable {
    let text: String
    let attributes: Attributes
}

struct SubmitButton: Codable {
    let text, submitEndpoint: String
    let attributes: Attributes
}

struct Attributes: Codable {
    let fontSize: Int
    let font, color: String
}

struct Link: Codable {
    let nextEndpoint: String
}

//"label": {
//    "name": "title",
//    "text": "Gain on Portfolio",
//    "attributes": {
//        "fontSize": 16,
//        "font": "futura",
//        "weight": "light",
//        "color": "#FFFFFF"
//    }
//},

