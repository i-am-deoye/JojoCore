//
//  Upload.swift
//  JojoCore
//
//  Created by Moses on 22/07/2019.
//  Copyright © 2019 flint. All rights reserved.
//

import Foundation


public struct UploadRequest {
    let fullUrl: String
    let contentTypeValue: String
    let boundary: String
    let fileName: String
    let data: Data
    
   public init(fullUrl: String, contentTypeValue: String, boundary: String, fileName: String, data: Data) {
        guard !fullUrl.isEmpty && !contentTypeValue.isEmpty && !boundary.isEmpty && !fileName.isEmpty && !data.isEmpty else {
            Logger.log(.e, messages: "fullUrl :: contentTypeValue :: boundary :: fileName :: data")
            Logger.log(.e, messages: "Your parameters can't be empty!!!")
            fatalError()
        }
        
        self.fullUrl = fullUrl
        self.contentTypeValue = contentTypeValue
        self.boundary = boundary
        self.fileName = fileName
        self.data = data
    }
}

public class Upload {
    public class func upload(_ uploadRequest: UploadRequest, headers: HTTPHeaders?, handler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let url = URL.init(string: uploadRequest.fullUrl)!
        var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 1200)
        request.httpMethod = HTTP.POST.rawValue
        let dataToUpload = getUploadData(uploadRequest.data, boundary: uploadRequest.boundary, fileName: uploadRequest.fileName)
        
        request.allHTTPHeaderFields = headers
        request.setValue("multipart/form-data; boundary=\(uploadRequest.boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(String(dataToUpload.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = dataToUpload
        request.httpShouldHandleCookies = false
        
        
        let config = URLSession.shared.configuration
        // make the memory and disk Cache 10MB each
        config.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        let session = URLSession.init(configuration: config)
        session.dataTask(with: request, completionHandler: handler)
    }
    
    
   private class func getUploadData(_ data: Data, contentTypeValue: String="image/jpg", boundary: String, fileName: String) -> Data {
        var fullData = Data()
        
        let startBoundary = "--\(boundary)\r\n"
        fullData.append(startBoundary.data(using: .utf8, allowLossyConversion: false)!)
        
        let contentDisposition = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        fullData.append(contentDisposition.data(using: .utf8, allowLossyConversion: false)!)
        
        let contentType = "Content-Type: \(contentTypeValue)\r\n\r\n"
        fullData.append(contentType.data(using: .utf8, allowLossyConversion: false)!)
        
        fullData.append(data)
        
        let afterDataAdded = "\r\n"
        fullData.append(afterDataAdded.data(using: .utf8, allowLossyConversion: false)!)
        
        let endBoundary = "--\(boundary)--\r\n"
        fullData.append(endBoundary.data(using: .utf8, allowLossyConversion: false)!)
        
        return fullData
    }
}
