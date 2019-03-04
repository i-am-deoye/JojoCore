
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public struct SuccessData {
    public var anyList : [Any]
    public var any : Any?
    public var message : String
    
    init(anyList: [Any], message: String) {
        self.anyList = anyList
        self.message = message
        self.any = anyList.first
    }
}
