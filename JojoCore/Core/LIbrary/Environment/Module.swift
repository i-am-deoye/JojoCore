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
    
    var environmentServer: Server
    var endpoint: Endpoint
    
    
    static func module(_ moduleName: String, enpointName: String) -> Module? {
        let modules : [Module] = Utils.loadFromPList(forResource: Module.plistName, handler: { onLoad(with: $0, moduleName: moduleName, enpointName: enpointName) })
        
        if modules.isEmpty { fatalError("modules can'nt be empy") }
        
        return modules.first
    }
    
    private static func onLoad(with root: NSDictionary, moduleName: String, enpointName: String) -> [Module] {
        
        guard let modulesRoot = root.value(forKey: "Modules") as? NSDictionary else { fatalError("modules not available") }
        guard let module = modulesRoot.value(forKey: moduleName) as? NSDictionary else { fatalError("module of \(moduleName) not available") }
        guard let environmentServerStringValue = module.value(forKey: "environmentServer") as? String else { fatalError("environmentServer for \(moduleName) not available") }
        
        
        guard let environmentRoot = root.value(forKey: "Servers") as? NSDictionary else { fatalError("Servers not available") }
        guard let environmentServerValue = environmentRoot.value(forKey: environmentServerStringValue) as? NSDictionary else { fatalError("server of \(environmentServerStringValue) not available") }
        guard let environmentServer = _Server(environmentServerStringValue, with: environmentServerValue, root: root) else { fatalError("environmentServerValue of \(environmentServerStringValue) cant be nil ") }
        
        
        guard let endpointValue = module.value(forKey: "endpoints") as? NSDictionary else { fatalError("Endpoint for \(moduleName) not available") }
        let endpt = endpoint(enpointName, with: endpointValue)
        
        
        return [Module.init(environmentServer: environmentServer, endpoint: endpt)]
    }
    
    private static func _Server(_ name: String, with value: NSDictionary, root: NSDictionary) -> Server? {
        
        var server = Server.init()
        
        
        if let environment = value.value(forKey: "environment") as? String,
            let enviroments = root.value(forKey: "Environments") as? NSDictionary,
            let environmentBaseUrl = enviroments.value(forKey: environment) as? String, !environmentBaseUrl.isEmpty {
            server.baseUrl = environmentBaseUrl
        } else {
            fatalError("set up environments for your base urls")
        }
        
        
        if let headerKey = value.value(forKey: "header") as? String,
            let headerRoot = root.value(forKey: "Headers") as? NSDictionary,
            let headerValue = headerRoot.value(forKey: headerKey) as? NSDictionary {
            server.header = HTTPHeaders()
            headerValue.allKeys.forEach { (key) in
                let k = key as! String
                server.header[k] = headerValue.value(forKey: k) as? String
            }
        } else {
            // Log warning
            Logger.log(.w, messages: "No Headers set for this \(name)")
        }
        
        return server
    }
    
    
    private static func endpoint(_ name: String, with module: NSDictionary) -> Endpoint {
        var endpoint = Endpoint()
        
        guard let endPoint = module.value(forKey: name) as? NSDictionary else { fatalError("enpoint \(name) not available") }
        
        guard let httpValue = endPoint.value(forKey: "http") as? String else { fatalError("http for \(name) enpoint not available") }
        guard let http = HTTP.init(rawValue: httpValue.uppercased()) else { fatalError("unable to parsed \(httpValue)") }
        
        endpoint.http = http
        
        if let isLive = endPoint.value(forKey: "isLive") as? Bool {
            endpoint.isLive = isLive
        } else {
            endpoint.isLive = true
        }
        
        if let live = endPoint.value(forKey: "live") as? String {
            endpoint.live = live
        } else {
            // Log warning
            Logger.log(.w, messages: "No enpoint specify for this \(name)")
        }
        
        if let mock = endPoint.value(forKey: "mock") as? String {
            endpoint.mock = mock
        } else {
            // Log warning
            Logger.log(.w, messages: "No Headers set for this \(name)")
        }
        
        return endpoint
    }
}
