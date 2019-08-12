//
//  OfflineOperation.swift
//  JojoCore
//
//  Created by Moses on 06/08/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation



typealias OfflineKeys = (url: String, body: String, method: String, headers: String)
typealias OfflineRequest = (url: String, body: JSON, method: HTTP, headers: HTTPHeaders)

public class OfflineOperation {
    private static var operateWhenOffline : Bool = false
    private static var operatedAtInterval : TimeInterval = 0
    
    public class func setup(_ operateWhenOffline: Bool, operatedAtInterval : TimeInterval) {
        OfflineOperation.operatedAtInterval = operatedAtInterval
        OfflineOperation.operateWhenOffline = operateWhenOffline
    }
    
   class private func getKeys(url: String) -> OfflineKeys {
        return (url+"URL", url+"BODY", url+"METHOD", url+"HEADERS")
    }
    
  class  func cacheRequest(_ url: String, body: JSON, method: HTTP, headers: HTTPHeaders) {
        
        let keys = OfflineOperation.getKeys(url: url)
        
        let cache = Utils.cache.putString(key: keys.url, value: url)
                   .putSerialize(key: keys.body, value: body)
                   .putString(key: keys.method, value: method.rawValue)
                   .putSerialize(key: keys.headers, value: headers)
        
        if var values = cache.getSerialize(key: "urls") as? [String] {
            values.append(url)
             _ = cache.putSerialize(key: "urls", value: values)
        } else {
            _ = cache.putSerialize(key: "urls", value: [url])
        }
    }
    
   class func getCachedRequest() -> [OfflineRequest]  {
        guard let urls = Utils.cache.getSerialize(key: "urls") as? [String] else { return [] }
        
        var container = [OfflineRequest]()
        
        for url in urls {
            
            let keys = OfflineOperation.getKeys(url: url)
            let cache = Utils.cache
            let body = cache.getSerialize(key: keys.body) as? JSON ?? JSON()
            let method =  HTTP.init(rawValue: cache.getString(key: keys.method) ?? "") ?? HTTP.GET
            let headers = cache.getSerialize(key: keys.headers) as? HTTPHeaders ?? HTTPHeaders()
            
            let request : OfflineRequest = (url, body, method, headers)
            container.append(request)
        }
        
        return container
    }
    
    class func remove(by url: String) {
        let keys = OfflineOperation.getKeys(url: url)
        Utils.cache.remove(key: keys.url)
        Utils.cache.remove(key: keys.body)
        Utils.cache.remove(key: keys.method)
        Utils.cache.remove(key: keys.headers)
    }
    
    public class func invoke() {
        let requests = getCachedRequest()
        
        for request in requests {
            DefaultConnection.init()
                .execute(uri: request.url,
                         method: request.method,
                         payload: request.body,
                         httpBody: request.body.isEmpty ? HTTPBodyType.parameter : HTTPBodyType.payload,
                         headers: request.headers) { (response) in
                            Logger.log(.v, messages: "OFFLINE ============ OFFLINE ======== OFFLINE ===========  :::: \(response)")
            }
        }
    }
}
