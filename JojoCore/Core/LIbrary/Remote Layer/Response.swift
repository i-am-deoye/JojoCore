
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

let parseError = "internal error"

public enum Response {
    case success(ResponseParameters)
    case error(String)
}



func  map(json: JSON) ->  Response  {
    
    let responseParameters = ResponseParameters.init(json: json)
    
    guard !responseParameters.isError else {
        Logger.log(.e, messages: json.toString ?? parseError)
        return Response.error(responseParameters.responseMessage ?? parseError)
    }
    
    guard responseParameters.isSuccessful || responseParameters.data != nil else { return Response.error(responseParameters.responseMessage ?? parseError) }
    guard responseParameters.data != nil else { return Response.error(responseParameters.responseMessage ?? parseError) }
    
    
    return Response.success(responseParameters)
}
