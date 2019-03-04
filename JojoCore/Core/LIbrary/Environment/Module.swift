//
//  Module.swift
//  JojoCore
//
//  Created by Moses on 01/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation

public struct Module {
   public static var plistName : String = ""
    
    var environmentServer: EnvironmentalServer
    var http: HTTP
    var endpoint: Endpoint
    
    
    static func module(_ moduleName: String) -> Module? {
        let modules : [Module] = Utils.loadFromPList(forResource: Module.plistName, handler: { onLoad(with: $0, moduleName: moduleName) })
        
        if modules.isEmpty { /* throw error here*/  return nil }
        
        return modules.first
    }
    
    private static func onLoad(with root: NSDictionary, moduleName: String) -> [Module] {
        
        guard let modulesRoot = root.value(forKey: "Modules") as? NSDictionary else { /* throw error here*/ return [] }
        guard let module = modulesRoot.value(forKey: moduleName) as? NSDictionary else { /* throw error here*/ return [] }
        guard let environmentServerStringValue = module.value(forKey: "environmentServer") as? String else { /* throw error here*/ return [] }
        
        guard let httpValue = module.value(forKey: "http") as? String else { /* throw error here*/ return [] }
        guard let http = HTTP.init(rawValue: httpValue.uppercased()) else { /* throw error here*/ return [] }
        
        
        guard let environmentRoot = root.value(forKey: "EnvironmentServers") as? NSDictionary else { /* throw error here*/ return [] }
        guard let environmentServerValue = environmentRoot.value(forKey: environmentServerStringValue) as? NSDictionary else { /* throw error here*/ return [] }
        guard let environmentServer = environmentServer(with: environmentServerValue, root: root) else { /* throw error here*/ return [] }
        
        
        guard let endpointValue = module.value(forKey: "endpoints") as? NSDictionary else { /* throw error here*/ return [] }
        let endpt = endpoint(with: endpointValue)
        
        
        return [Module.init(environmentServer: environmentServer, http: http, endpoint: endpt)]
    }
    
    private static func environmentServer(with value: NSDictionary, root: NSDictionary) -> EnvironmentalServer? {
        
        var server = EnvironmentalServer.init()
        
        guard let baseUrl = value.value(forKey: "baseUrl") as? String, !baseUrl.isEmpty else { return nil }
        server.baseUrl = baseUrl
        
        if let isLive = value.value(forKey: "isLive") as? Bool {
            server.isLive = isLive
        }
        
        if let headerAuthType = value.value(forKey: "headerAuthType") as? String {
            server.headerAuthType = headerAuthType
        } else {
            // Log
        }
        
        if let algorithm = value.value(forKey: "algorithm") as? String, let isCrypto = value.value(forKey: "isCrypto") as? Bool  {
            server.algorithm = algorithm
            server.isCrypto = isCrypto
        } else {
            // Log
        }
        
        
        if let header = value.value(forKey: "header") as? String, let headerValue = root.value(forKey: "Headers") as? NSDictionary {
            server.header = Headers()
            headerValue.allKeys.forEach { (key) in
                let k = key as! String
                server.header[k] = headerValue.value(forKey: k) as? String
            }
        } else {
            // Log warning
        }
        
        return server
    }
    
    
    private static func endpoint(with module: NSDictionary) -> Endpoint {
        var endpoint = Endpoint()
        
        if let live = module.value(forKey: "live") as? String {
            endpoint.live = live
        } else {
            // Log warning
        }
        
        if let mock = module.value(forKey: "mock") as? String {
            endpoint.mock = mock
        } else {
            // Log warning
        }
        
        return endpoint
    }
}
