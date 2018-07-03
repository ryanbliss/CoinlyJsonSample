//
//  EditJsonViewModel.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/17/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MyJSON {
    var key: String
    var json: JSON
}

class EditJsonViewModel {
    static var json: JSON = JSON() {
        didSet {
            if EditJsonViewModel.jsonPath.isEmpty {
                let sub = MyJSON(key: "home", json: EditJsonViewModel.json)
                EditJsonViewModel.jsonPath.append(sub)
                EditJsonViewModel.subJson = EditJsonViewModel.json
            }
        }
    }
    static var jsonPath: [MyJSON] = []
    static var subJson: JSON = JSON() // this should always equal the last item in jsonPath
    
    init() {
        setup()
    }
    
    func setup() {
        let blah = NetworkingManager().getSwiftyJson(for: "testy")
        guard let data = blah else { return }
        EditJsonViewModel.json = data
    }
    
    func save() {
        if let text = EditJsonViewModel.json.rawString() {
            // Bundle save
//            if let file = Bundle.main.url(forResource: "testy", withExtension: "json") {
//                do {
//                    try text.write(to: file, atomically: false, encoding: .utf8)
//                } catch {
//                    return
//                }
//            } else {
//                print("no file")
//                return
//            }
            // Directory save
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let fileURL = dir.appendingPathComponent("testy.json")
                
                //writing
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {/* error handling here */}
                
                //reading
                do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                }
                catch {/* error handling here */}
            }
        } else {
            print("json.rawString is nil")
        }
    }
    
    enum JsonCellTypes: String {
        case value = "value"
        case more = "more"
    }
    
    func getNavTitle() -> String {
        guard let title = EditJsonViewModel.jsonPath.last?.key else { return "Base" }
        if title == "" {
            return "Base"
        }
        return title
    }
    
    func getCellType(for row: Int) -> JsonCellTypes {
        var i = 0
        for (_,subJson):(String, JSON) in EditJsonViewModel.subJson {
            // Do something you want
            if i == row {
                if let _ = subJson.string {
                    return JsonCellTypes(rawValue: "value")!
                } else if let _ = subJson.int {
                    return JsonCellTypes(rawValue: "value")!
                } else if let _ = subJson.double {
                    return JsonCellTypes(rawValue: "value")!
                }
            } else {
                i += 1
            }
        }
        return JsonCellTypes(rawValue: "more")!
    }
    
    func getRowCount() -> Int {
        return EditJsonViewModel.subJson.count
    }
    
    func getTitle(for row: Int) -> String {
        var i = 0
        for (key,_):(String, JSON) in EditJsonViewModel.subJson {
            // Do something you want
            if i == row {
                return key
            } else {
                i += 1
            }
        }
        return ""
    }
    
    func getSubtitle(for row: Int) -> String {
        var i = 0
        for (_,value):(String, JSON) in EditJsonViewModel.subJson {
            // Do something you want
            if i == row {
                return value.stringValue
            } else {
                i += 1
            }
        }
        return ""
    }
    
    func setNextSubJson(for title: String?) {
        guard let key = title else {return}
        let subJson = EditJsonViewModel.subJson
        var newSubJson = JSON()
        if let array = subJson.array {
            newSubJson = array[Int(key)!]
        } else {
            newSubJson = subJson[key]
        }
        EditJsonViewModel.subJson = newSubJson
        let sub = MyJSON(key: key, json: EditJsonViewModel.subJson)
        EditJsonViewModel.jsonPath.append(sub)
        
    }
    
    func goBack() {
        if EditJsonViewModel.jsonPath.count > 1 {
            let _ = EditJsonViewModel.jsonPath.popLast()
        }
        guard let last = EditJsonViewModel.jsonPath.last else {return}
        EditJsonViewModel.subJson = last.json
    }
    
    func editValue(for title: String, with text: String) {
        if EditJsonViewModel.subJson[title].string != nil {
            EditJsonViewModel.subJson[title].stringValue = text
        } else if EditJsonViewModel.subJson[title].bool != nil {
            EditJsonViewModel.subJson[title].boolValue = Bool(text)!
        } else if EditJsonViewModel.subJson[title].double != nil {
            EditJsonViewModel.subJson[title].doubleValue = Double(text)!
        } else if EditJsonViewModel.subJson[title].int != nil {
            EditJsonViewModel.subJson[title].intValue = Int(text)!
        }
        
        update()
    }
    
    private func update() {
        var last = EditJsonViewModel.jsonPath.last!
        last.json = EditJsonViewModel.subJson
        
        EditJsonViewModel.jsonPath.removeLast()
        EditJsonViewModel.jsonPath.append(last)
        
        var newJsonPath: [MyJSON] = []
        newJsonPath.append(last)
        var previousJson = last
        
        for currentJson in EditJsonViewModel.jsonPath.reversed() {
            if currentJson.key != previousJson.key {
                var newJson = currentJson
                if newJson.json.array != nil {
                    var newArray = newJson.json.arrayValue
                    newArray[Int(previousJson.key)!] = previousJson.json
                    newJson.json.arrayObject = newArray
                } else {
                    newJson.json[previousJson.key] = previousJson.json
                }
                
                newJsonPath.append(newJson)
                previousJson = newJson
            }
        }
        newJsonPath.reverse()
        
        EditJsonViewModel.jsonPath = newJsonPath
        EditJsonViewModel.json = EditJsonViewModel.jsonPath.first!.json
        save()
    }
    
    func reset() {
        EditJsonViewModel.json = EditJsonViewModel.subJson
        EditJsonViewModel.jsonPath = [EditJsonViewModel.jsonPath.first!]
    }
    
    func remove(for row: Int) {
        if EditJsonViewModel.subJson.array != nil {
            var newArray = EditJsonViewModel.subJson.arrayValue
            newArray.remove(at: row)
            EditJsonViewModel.subJson.arrayObject = newArray
        } else {
            var newSubjson = EditJsonViewModel.subJson.dictionary!
            newSubjson.removeValue(forKey: getTitle(for: row))
            EditJsonViewModel.subJson.dictionaryObject = newSubjson
        }
        update()
    }
    
    func reorder(fromRow: Int, toRow: Int) {
        if EditJsonViewModel.subJson.array != nil {
            var newArray = EditJsonViewModel.subJson.arrayValue
            let fromValue = newArray[fromRow]
            let toValue = newArray[toRow]
            newArray[fromRow] = toValue
            newArray[toRow] = fromValue
            EditJsonViewModel.subJson.arrayObject = newArray
            
            update()
        }
    }
}
