//
//  Repository.swift
//  RemitaPayroll
//
//  Created by Moses on 04/10/2018.
//  Copyright © 2018 Systemspecs. All rights reserved.
//

import Foundation


typealias ILocalRepository = IRepositoryCRUD & IRepositoryQuery

open class LocalRepository <E> : ILocalRepository where E : Persistable {
    
    public typealias T = E
    public var entityClass: E.Type!
    private var db : IDataBase!
    
    private init() {}
    
    public init(entityClass: E.Type, db: IDataBase?) {
        
        guard let db = db else { Logger.log(.s, messages: "IDataBase cant be nil"); return }
        
        self.entityClass = entityClass
        self.db = db
    }
    
    private func isPersistable(_ entity: Any) -> Bool {
        guard entity is Persistable else { return false }
        return true
    }
    
    private func throwIfPersistableError(_ entity: T) {
        assert(isPersistable(entity), "Persistable must be implemented to your Entity Class")
    }
    
    public func save(_ entity: E)  {
        throwIfPersistableError(entity)
        db.write(entity)
    }
    
    public func save(_ entities: [E]) {
        entities.forEach({ self.save($0) })
    }
    
    public func fetch(by id: String) -> [E] {
        let result = db.fetch(entityClass)
        return result
    }
    
    public func fetch() -> [E] {
        let result = db.fetch(entityClass)
        return result
    }
    
    public func update(_ handle: @escaping (() -> T)) {
            db.update(handle)
    }
    
    public func delete(_ entity: E) {
        db.delete(entity)
    }
    
    public func fetch(by query: Query) -> [E] {
        var result = db.fetch(entityClass)
        result = db.filter(E.self, query: query.toString())
        return result
    }
    
    public func delete(by query: Query) {
        let result = db.fetch(entityClass)
        db.delete(result)
    }
    
}


