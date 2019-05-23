//
//  Endpoint.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class Endpoint {
    
    let url: URL
    let path: String?
    let httpMethod: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    
    init(url: URL, path: String? = nil, httpMethod: HTTPMethod = .get, parameters: Parameters = [:], headers: HTTPHeaders = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
    }
    
    func createRequest() -> DataRequest {
        var url: URL
        if self.path != nil {
            url = URL(string: self.path!, relativeTo: self.url)!
        } else {
            url = self.url
        }
        
        let encodingType : URLEncoding
        
        if self.httpMethod == .get {
            encodingType = URLEncoding.queryString
            return Alamofire.request(url,
                                     method: self.httpMethod,
                                     parameters: parameters,
                                     encoding: encodingType,
                                     headers: headers)
        } else {
            return Alamofire.request(url,
                                     method: self.httpMethod,
                                     parameters: parameters,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        }
    }
}

extension DataRequest {
    public func consoleLog() -> Self {
        return self
    }
}
