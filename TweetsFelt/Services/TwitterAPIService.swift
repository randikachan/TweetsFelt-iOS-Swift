//
//  TwitterService.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterAPIService : NetworkClient {
    
    // MARK: - Singleton
    static let shared = TwitterAPIService()
    
    func getBearerToken(endpoint: Endpoint, completion: @escaping WebServiceResponse) {
        execute(.POST, url: endpoint.url, completion: completion)
    }
}
