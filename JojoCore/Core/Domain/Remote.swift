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
    
   public var headers = Headers()
   public var httpBody: HTTPBodyType = .parameter
    
    
   public init() { }
   public init(security: ISecurity) {
        self.security = security
   }
   
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
        
        let handleResponse = { (responseValue : Response) in
            
            if self.security != nil { // isCrypto
                
                switch responseValue {
                case .error(let errorMessge):
                    Logger.log(.e, messages: errorMessge)
                    response(Response.error(errorMessge))
                case .success(let successData):
                    Logger.log(.i, messages: successData.message)
                    if let value = successData.any {
                        let decrypted = self.security?.decrypt(value) // decrypted data
                        let successData = SuccessData.init(anyList: [decrypted as Any], message: successData.message)
                        response(Response.success(successData))
                    } else {
                        let successData = SuccessData.init(anyList: [], message: successData.message)
                        response(Response.success(successData))
                    }
                }
                
            } else {
                response(responseValue)
            }
        }
        
        switch http {
        case .GET:
            self.httpBody = .parameter
            self.get(url: url, handle: handleResponse)
        case .POST:
            guard let requestValue = request else { fatalError("request is required for POST method") }
            self.httpBody = .payload
            self.post(url: url, payload: requestValue, handle: handleResponse)
        default: break
        }
    }
    
}



