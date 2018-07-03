//
//  FontDetect.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/11/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class FontDetect {
    static func printAll() {
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}
