//
//  ModuleExcutor.swift
//  JojoCore
//
//  Created by Moses on 25/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


public struct ModuleExcutor : IModule {
   public var headers = HTTPHeaders()
   public var http: HTTP = .GET
   public var url: String = ""
    
    
    static var plistName : String = ""
    
    
    public static func execute(_ moduleName: String, endPoint: String, otherHeaders: HTTPHeaders=HTTPHeaders()) -> IModule? {
        guard let module = Module.module(moduleName) else { return nil }
        
        let headers = (module.environmentServer.header as Dictionary) + (otherHeaders as Dictionary)
        let http = module.http
        let url = module.endpoint.url(baseUrl: module.environmentServer.baseUrl, isLive: module.environmentServer.isLive)
        
        return ModuleExcutor.init(headers: headers, http: http, url: url)
    }
    
    
}
