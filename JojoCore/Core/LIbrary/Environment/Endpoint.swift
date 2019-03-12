//
//  Endpoint.swift
//  JojoCore
//
//  Created by Moses on 25/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


struct Endpoint {
    var http = HTTP.GET
    var live = ""
    var mock = ""
    var isLive = false
    
    func url(baseUrl: String) -> String {
        let api = isLive ? live : mock
        let url = baseUrl + api
        return url
    }
}
