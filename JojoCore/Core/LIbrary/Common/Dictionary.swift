//
//  Dictionary.swift
//  RemitaPayroll
//
//  Created by Moses on 04/10/2018.
//  Copyright © 2018 Systemspecs. All rights reserved.
//

import Foundation


public extension Dictionary {
    
   public var data : Data? {
        let dataString = self.toString
        return dataString?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)
    }
    
   public var toString : String? {
        if let json = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let content = String(data: json, encoding: String.Encoding.utf8) {
                return content
            }
            return nil
        }
        return nil
    }
    
   public var stringFromHttpParameters : String {
        guard !self.isEmpty else { return "" }
        
        var parametersString = ""
        for (key, value) in self {
            if let key = key as? String,
                let value = value as? String {
                parametersString = parametersString + key + "=" + value + "&"
            }
        }
        parametersString = String(parametersString[..<parametersString.index(before: parametersString.endIndex)])
        return parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
   public static func set(itemId: String, amount: Double ) -> JSON {
        var object = JSON()
        object[itemId] = amount
        return object
    }
}
