//
//  Service.swift
//  JojoCore
//
//  Created by Moses on 01/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation

public typealias RemoteResponse = ((Response) -> Void)

final public class Remote : RemoteLayer {
   fileprivate var security : ISecurity?
    
   public var headers = HTTPHeaders()
   public var httpBody: HTTPBodyType = .parameter
    
    
   public init() { }
   
   public func getConnection() -> IConnection? {
        return DefaultConnection.init()
   }
    
   public func execute(_ builder: RemoteBuilder) {
    
       let encrypted : Any? = self.security?.encrypt(builder.request)
       let request : Any = encrypted != nil ? encrypted! : builder.request as Any
    
        if let headers = builder.headers {
            self.headers = headers
        }
        execute(builder.url, request:request, http: builder.http, response: builder.response)
   }
    
    public func execute(_ url: String, request: Any?=nil, http: HTTP, response: @escaping RemoteResponse)  {
        switch http {
        case .GET:
            self.httpBody = .parameter
            self.get(url: url, handle: response)
        case .POST:
            guard let requestValue = request else { fatalError("request is required for POST method") }
            self.httpBody = .payload
            self.post(url: url, payload: requestValue, handle: response)
        default: break
        }
    }
    
}



