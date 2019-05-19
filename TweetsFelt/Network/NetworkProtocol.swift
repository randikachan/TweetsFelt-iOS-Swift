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
    
    func execute(_ endpoint: Endpoint, completion: @escaping WebServiceResponse)

}
