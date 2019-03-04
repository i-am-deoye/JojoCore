
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

struct Payload {
    
    var status: Bool = false
    var messages = [String]()
    var data = [Any]()
    var error : String = ""
    
    var defaultResponseData: Any? {
        get {
            var response: Any? = .none
            
            if (hasPayload()) {
                response = data[0]
            }
            
            return response
        }
    }
    
    var message : String {
        get {
            return messages.first ?? ""
        }
    }
    
    init() {}
    
    mutating func parse(_ json: JSON) -> Any? {
        
        self.status = json["valid"] as? Bool ?? false
        self.messages = json["messages"] as? [String] ?? []
        self.data = json["responseData"] as? [Any] ?? []
        self.error = json["error"] as? String ?? ""
        return self
    }

    
    func hasPayload() -> Bool {
        return !data.isEmpty
    }
    
    var isSuccessful: Bool {
        return status
    }
    
}
