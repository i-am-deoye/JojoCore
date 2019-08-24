
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public protocol IRemoteRepository : IRestful {
    var httpBody : HTTPBodyType { get set }
    var headers : HTTPHeaders { get set }
    func getConnection() -> IConnection?
}


extension IRemoteRepository  {
    
    
   public func get(url: String, handle: @escaping ((Response) -> Void) )  {
        guard let connection = getConnection() else { Logger.log(.s, messages: ConnectionNotSet().localizedDescription); return }
    
        connection.execute(uri: url, method: HTTP.GET, payload: JSON(), httpBody: httpBody, headers: headers, handle: handle)
    }
    
   public func post(url: String, payload: Any, handle: @escaping ((Response) -> Void) ) {
        guard let connection = getConnection() else { Logger.log(.s, messages: ConnectionNotSet().localizedDescription); return }
        connection.execute(uri: url, method: HTTP.POST, payload: payload, httpBody: httpBody, headers: headers, handle: handle)
    }
    
    public func put(url: String, payload: Any, handle: @escaping ((Response) -> Void) ) {
        guard let connection = getConnection() else { Logger.log(.s, messages: ConnectionNotSet().localizedDescription); return }
        connection.execute(uri: url, method: HTTP.PUT, payload: payload, httpBody: httpBody, headers: headers, handle: handle)
    }
    
    public func delete(url: String, handle: @escaping ((Response) -> Void) )  {
        guard let connection = getConnection() else { Logger.log(.s, messages: ConnectionNotSet().localizedDescription); return }
        connection.execute(uri: url, method: HTTP.DELETE, payload: JSON(), httpBody: httpBody, headers: headers, handle: handle)
    }
}


