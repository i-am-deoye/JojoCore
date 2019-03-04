//
//  CoreError.swift
//  ioscore
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

struct ConnectionNotSet : Error {
    var localizedDescription: String = "IConnection found to be nil"
}
