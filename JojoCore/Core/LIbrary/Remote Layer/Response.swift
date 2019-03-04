
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

let parseError = "internal error"

public enum Response {
    case success(SuccessData)
    case error(String)
}



func  map(json: JSON) ->  Response  {
    
    var payload = Payload.init()
    guard let mapped : Payload = payload.parse(json) as? Payload else { return Response.error(parseError) }

    guard !mapped.data.isEmpty else { return Response.error(mapped.message) }
    
    guard mapped.isSuccessful else { return Response.error(mapped.message)  }
    
    let successData = SuccessData.init(anyList: mapped.data, message: mapped.message)
    return Response.success(successData)
}
