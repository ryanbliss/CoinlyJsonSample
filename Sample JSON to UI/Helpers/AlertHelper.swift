//
//  AlertHelper.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/11/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class AlertHelper {
    static func createBasicAlert(_ title: String?, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
