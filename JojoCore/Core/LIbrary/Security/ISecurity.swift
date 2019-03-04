//
//  ISecurity.swift
//  JojoCore
//
//  Created by Moses on 27/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


public protocol ISecurity {
    func decrypt(_ value: Any) -> JSON?
    func encrypt(_ value: JSON) -> String?
}
