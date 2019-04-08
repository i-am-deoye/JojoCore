//
//  RealmDB.swift
//  ioscore_example
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDB : IDataBase {
    private var realm : Realm!
    init() {
        do {
            self.realm = try Realm()
        } catch {
            Logger.log(.e, messages: error.localizedDescription)
        }
    }
    
    func write<T>(_ entity: T) {
        do {
            try realm.write {
                realm.add(entity as! Object, update: true)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    func update<T>(_ handle: @escaping (() -> T)) {
        do {
            realm.beginWrite()
            _ = handle()
            try realm.commitWrite()
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    func delete<T>(_ entity: T) {
        do {
            try realm.write {
                realm.delete(entity as! Object)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    func delete<T>(_ entities: [T]) {
        entities.forEach({ self.delete($0) })
    }
    
    func fetch<T>(_ type: T.Type) -> [T] {
        let result = realm.objects(type as! Object.Type)
        return computeToList(result: result) as! [T]
    }
    
    func filter<T>(_ type: T.Type, query: String) -> [T] {
        let result = realm.objects(type as! Object.Type).filter(query)
        return computeToList(result: result) as! [T]
    }
    
    fileprivate func computeToList<T>(result: Results<T>) -> [T] {
        var list: [T] = []
        
        for item in result {
            list.append(item)
        }
        
        return list
    }
}
