//
//  IRepositoryCRUD.swift
//  RemitaPayroll
//
//  Created by Moses on 04/10/2018.
//  Copyright © 2018 Systemspecs. All rights reserved.
//

import Foundation


protocol IRepositoryCRUD {
    associatedtype T
    
    func save(_ entity: T)
    func save(_ entities: [T])
    func fetch(by id: String)  -> [T]
    func fetch() -> [T]
    func update(_ handle: @escaping (() -> T ) )
    func delete(_ entity: T)
}
