//
//  ResponseParameters.swift
//  JojoCoreTests
//
//  Created by Moses on 11/03/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


public enum ResponseParameterKey {
    case Data
    case ResponseCode
    case Message
}

public struct ResponseParameters {
    public static var keys = [ResponseParameterKey:String]()
    public static var successConditions = [String]()
    
    public let json : JSON
    
    public var data : [JSON]? {
        
        guard let list = json[ResponseParameters.keys[ResponseParameterKey.Data] ?? ""] as? [JSON] else {
            let value = json[ResponseParameters.keys[ResponseParameterKey.Data] ?? ""] as? JSON
            return value == nil ? nil : [value!]
        }
        return list
    }
    
    public var responseCode : Any? {
        return json[ResponseParameters.keys[ResponseParameterKey.ResponseCode] ?? ""]
    }
    
    public var responseMessage : String? {
        return json[ResponseParameters.keys[ResponseParameterKey.Message] ?? ""] as? String
    }
    
    public var isSuccessful : Bool {
        return !ResponseParameters.successConditions
                                  .filter({ (self.responseCode as? String) == $0 || ( "\(self.responseCode as? Int ?? 999)" ) == $0 })
                                  .isEmpty
    }
    
    public var isError : Bool {
        return data == nil
    }
    
}
