//
//  NetworkProtocol.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

protocol NetworkProtocol {

    // WebServiceResponse Typealias
    typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
    
    func execute(_ httpMethod: HTTP_VERB, url: URL, completion: @escaping WebServiceResponse)

}
