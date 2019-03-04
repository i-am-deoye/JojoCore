//
//  IDataBase.swift
//  ioscore
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public protocol IDataBase {
    func write<T>(_ entity: T)
    func update<T>(_ handle: @escaping (() -> T ) )
    func delete<T>(_ entity: T)
    func delete<T>(_ entities: [T])
    func fetch<T>(_ type: T.Type) -> [T]
    func filter<T>(_ type: T.Type, query: String) -> [T]
}
