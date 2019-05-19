//
//  Endpoint.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

struct Endpoint {
    
    let url: URL
    let path: String?
    let httpMethod: HTTP_VERB
    let parameters: [String: String]
    
    init(url: URL, path: String? = nil, httpMethod: HTTP_VERB = .GET, parameters: [String: String] = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
