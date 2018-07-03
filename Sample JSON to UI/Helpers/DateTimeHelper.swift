//
//  DateTimeHelper.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class DateTimeHelper {
    func convertToString(for timestamp: Int, includeTime: Bool) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/YY"
        var strDate = dateFormatter.string(from: date)
        
        if includeTime {
            dateFormatter.dateFormat = "h:mm a" //Specify your format that you want
            strDate += " at " + dateFormatter.string(from: date)
        }
        
        return strDate
    }
}
