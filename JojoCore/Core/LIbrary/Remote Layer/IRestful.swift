

//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public typealias JSON = [String : Any]
public typealias URLConvertible = String
public typealias HTTPHeaders = [String : String]
public typealias Parameters = Dictionary<String,String>
public typealias Headers = [String: String]


public enum HTTPBodyType {
    case payload, parameter
}

public protocol IRestful {
    func get(url: String, handle: @escaping ((Response) -> Void) )
    func post(url: String, payload: Any, handle: @escaping ((Response) -> Void) )
}
