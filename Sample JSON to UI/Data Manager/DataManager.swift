//
//  NetworkManager.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation

class DataManager {
    func read(_ data: Data) -> Base? {
        do {
            let decoder = JSONDecoder()
            let baseData = try decoder.decode(Base.self, from: data)
//            print(baseData.sections)
            return baseData
        } catch let err {
            print("Err", err)
        }
        return nil
    }
}

func jsonToData(with json: Any) -> Data? {
    do {
        return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil;
}

