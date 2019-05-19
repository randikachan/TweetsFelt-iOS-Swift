//
//  Endpoint.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Alamofire

class Endpoint {
    
    let url: URL
    let path: String?
    let httpMethod: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    
    init(url: URL, path: String? = nil, httpMethod: HTTPMethod = .get, parameters: Parameters = [:], headers: HTTPHeaders) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
    }
    
    func createRequest() -> DataRequest {
        let url = self.path.map({ self.url.appendingPathComponent($0) }) ?? self.url
        
        let encodingType : URLEncoding
        
        if self.httpMethod == .get {
            encodingType = URLEncoding.queryString
        } else {
            encodingType = URLEncoding.methodDependent
        }
        
        let request: DataRequest = Alamofire.request(url,
                                                     method: self.httpMethod,
                                                     parameters: parameters,
                                                     encoding: URLEncoding.queryString,
                                                     headers: headers)
        
        print("Request: \(request.consoleLog())")
        
        return request
    }
}

extension DataRequest {
    public func consoleLog() -> Self {
        return self
    }
}
