//
//  Utils.swift
//  RemitaPayroll
//
//  Created by Moses on 23/10/2018.
//  Copyright © 2018 Systemspecs. All rights reserved.
//

import Foundation
import LocalAuthentication



struct Utils {
    
   public static var cache : ICache {
        return SharedPreferenceCache.init()
    }
    
   public static func setToken(_ value: String) {
        _ = cache.putString(key: Constants.authorizationKey.rawValue, value: value)
    }
    
   public static func getToken() -> String {
        return cache.getString(key: Constants.authorizationKey.rawValue) ?? ""
    }
    
   public static func removeToken() {
        cache.remove(key: Constants.authorizationKey.rawValue)
    }
    
   public static var isAuth : Bool {
        return !getToken().isEmpty
    }
    
   public static func loadFromPList<T>(forResource: String, handler: @escaping ((NSDictionary) -> [T]) ) -> [T] {
        let bundle = Bundle.main
        
        guard let dashboardItemsUrl = bundle.url(forResource: forResource, withExtension: "plist") else {
            fatalError("Unable to determine URL for \(forResource) plist")}
        
        
        guard let fileContents  = NSDictionary(contentsOf: dashboardItemsUrl) else {
            fatalError("Unable to load \(forResource) plist")
        }
        
        return handler(fileContents)
    }
}
