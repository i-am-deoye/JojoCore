//
//  DefaultConnection.swift
//  ioscore_example
//
//  Created by Moses on 04/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

protocol ICrypto {
    func encrypt(with value: String) -> String?
    func decrypt(with value: String) -> String?
}

class  DefaultConnection : NSObject, IConnection, URLSessionDataDelegate  {
    
    private var completionHandler:((Response) -> Void)?
    private var cacheDuration: Int?
    private var data: Data
    
    
    override init() {
        data = Data()
        super.init()
    }
    
    convenience init(cacheDuration: Int? = nil) {
        self.init()
        self.cacheDuration = cacheDuration
    }
    
    
    private func connect(uri: URLConvertible,
                 method: HTTP,
                 body: Any?,
                 httpBody: HTTPBodyType,
                 headers: HTTPHeaders?,
                 completion: ((Response) -> ())?) throws {
        
        self.completionHandler = completion
        guard let uri = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL.init(string: uri) else { return  }
        
        
        var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 1200)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch httpBody {
        case .payload:
            request.httpBody = body! is JSON ?  try JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted) : (body as? String ?? "").data(using: String.Encoding.utf8, allowLossyConversion: false)
            break
        case .parameter:
            break
        }
        
        
        
        let config = URLSession.shared.configuration
        // make the memory and disk Cache 10MB each
        config.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        let queue = URLSession.shared.delegateQueue
        // let urlSession = URLSession.shared
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: queue)
        let task = session.dataTask(with: request)
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            
            
            
            if let response = task.response, let headers = (response as? HTTPURLResponse)?.allHeaderFields {
                Logger.log(.i, messages: "RESPONSE HEADER : \(response)")
                if let token = headers["Authorization"] as? String, !token.isEmpty {
                    Utils.setToken(token)
                }
            }
            
            
            var response : Response!
            do {
                if let json = try JSONSerialization.jsonObject(with: self.data, options: []) as? JSON {
                    Logger.log(.i, messages: "RESPONSE JSON : \(json)")
                    response = map(json: json)
                } else {
                    response = Response.error("Empty Payload")
                }
            } catch {
                response = Response.error(parseError)
            }
            
            guard let handler =  self.completionHandler else { return }
            
            Logger.log(.i, messages: "RESPONSE : \(response!)")
            handler(response)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        
        if let cacheDuration = cacheDuration, dataTask.currentRequest?.cachePolicy == .useProtocolCachePolicy {
            let newResponse = proposedResponse.response(withExpirationDuration: cacheDuration)
            completionHandler(newResponse)
        }else {
            completionHandler(proposedResponse)
        }
    }
    
    func execute(uri: String, method: HTTP, payload: Any?, httpBody: HTTPBodyType, headers: Headers, handle: @escaping ((Response) -> Void)) {
        
        do {
            try connect(uri: uri, method: method, body: payload, httpBody: httpBody, headers: headers, completion: handle)
        } catch {
            let response = Response.error(error.localizedDescription)
            handle(response)
        }
    }
}


extension CachedURLResponse {
    func response(withExpirationDuration duration: Int) -> CachedURLResponse {
        var cachedResponse = self
        if let httpResponse = cachedResponse.response as? HTTPURLResponse, var headers = httpResponse.allHeaderFields as? [String : String], let url = httpResponse.url{
            headers["Cache-Control"] = "max-age=\(duration)"
            headers.removeValue(forKey: "Expires")
            headers.removeValue(forKey: "s-maxage")
            
            if let newResponse = HTTPURLResponse(url: url, statusCode: httpResponse.statusCode, httpVersion: "HTTP/1.1", headerFields: headers) {
                cachedResponse = CachedURLResponse(response: newResponse, data: cachedResponse.data, userInfo: headers, storagePolicy: cachedResponse.storagePolicy)
            }
        }
        return cachedResponse
    }
}
