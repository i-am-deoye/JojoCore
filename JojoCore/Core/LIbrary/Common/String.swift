//
//  String.swift
//  JojoCore
//
//  Created by Moses on 02/07/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation

extension String {
    
    /*
     let variablePaths = "{id}".variablePaths("102111111") + "{key}".variablePaths("GHJG@#@kjh")
     */
    func variablePaths(_ value: String) -> VariablePaths {
        
        if !(self.contains("{") && self.contains("}")) {
            Logger.log(.e, messages: "path not configured properly!")
            fatalError()
        }
        
        var container = VariablePaths()
        container[self] = value
        return container
    }
}

