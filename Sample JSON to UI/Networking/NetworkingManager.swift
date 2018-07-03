//
//  NetworkingManager.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkingManager {
    func getData(for endpoint: String) -> Base? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // check for overridden json files
            let data = dir.appendingPathComponent("\(endpoint).json")
            do {
                let data = try Data(contentsOf: data)
                return DataManager().read(data)
            } catch {
                // Fall back to bundle files
                if let file = Bundle.main.url(forResource: endpoint, withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: file)
                        return DataManager().read(data)
                    } catch {
                        return nil
                    }
                } else {
                    print("no file")
                    return nil
                }
            }
        }
        return nil
    }
    
    func getSwiftyJson(for endpoint: String) -> JSON? {
        if let file = Bundle.main.url(forResource: endpoint, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let json = try JSON(data: data)
                return json
            } catch {
                return nil
            }
        } else {
            print("no file")
            return nil
        }
    }
}
