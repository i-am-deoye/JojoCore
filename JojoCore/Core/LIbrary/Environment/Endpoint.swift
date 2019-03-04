//
//  Endpoint.swift
//  JojoCore
//
//  Created by Moses on 25/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


struct Endpoint {
    var live = ""
    var mock = ""
    
    func url(baseUrl: String, isLive: Bool) -> String {
        let api = isLive ? live : mock
        let url = baseUrl + api
        return url
    }
}
