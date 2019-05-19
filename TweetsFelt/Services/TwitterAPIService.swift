//
//  TwitterService.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Alamofire

class TwitterAPIService : NetworkClient {
    
    // MARK: - Singleton
    static let shared = TwitterAPIService()
    
    func getBearerToken(api_key: String, api_secret: String, completion: @escaping WebServiceResponse) {
        let credentials = "\(api_key):\(api_secret)".data(using: .utf8)!
        
        let credentialsBase64 = credentials.base64EncodedString(options: [])
        
        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_ACCESS_TOKEN.rawValue,
                                httpMethod: .post,
                                parameters: ["grant_type": "client_credentials"],
                                headers: ["Authorization": "Basic \(credentialsBase64)"])

        execute(endpoint, completion: completion)
    }
}
