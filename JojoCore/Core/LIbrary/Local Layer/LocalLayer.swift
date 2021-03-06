//
//  LocalRepository.swift
//  ioscore_example
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation


public class LocalLayer<E:Persistable> : LocalRepository<E> {
    public init(entityClass: E.Type) {
        super.init(entityClass: entityClass, db: nil)
    }
}
