//
//  IModule.swift
//  JojoCore
//
//  Created by Moses on 25/02/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation

public protocol IModule {
    var headers: Headers { get set }
    var http: HTTP { get set }
    var url: String { get set }
    
}












