//
//  RemoteBuilder.swift
//  JojoCore
//
//  Created by Moses on 27/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


public class RemoteBuilder {
    public var response: RemoteResponse
    public var request: JSON = JSON()
    
    public var headers: Headers?
    public var http: HTTP = HTTP.GET
    public var url: String = ""
    
    
    
    public init(module: IModule, parameter: Parameters=Parameters(), request: JSON=JSON(), response:@escaping RemoteResponse) {
        self.http = module.http
        self.response = response
        self.headers = module.headers
        self.request = request
        self.url = module.url + parameter.stringFromHttpParameters
    }
}
