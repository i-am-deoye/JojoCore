//
//  IRepositoryQueryCRUD.swift
//  RemitaPayroll
//
//  Created by Moses on 04/10/2018.
//  Copyright © 2018 Systemspecs. All rights reserved.
//

import Foundation

protocol IRepositoryQuery {
    associatedtype T
    
    func fetch(by query: Query)  -> [T]
    func delete(by query: Query) 
}
