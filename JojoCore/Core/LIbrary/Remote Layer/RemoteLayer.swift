//
//  RemoteLayer.swift
//  ioscore_example
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public protocol RemoteLayer : IRemoteRepository {

}

extension RemoteLayer {
    
    public func getConnection() -> IConnection? {
        return DefaultConnection.init()
    }
}
