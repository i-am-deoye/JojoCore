//
//  IConnection.swift
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public protocol IConnection {
    func execute(uri: String,
                          method: HTTP,
                          payload: Any?,
                          httpBody: HTTPBodyType,
                          headers: Headers, handle: @escaping ((Response) -> Void))
}
