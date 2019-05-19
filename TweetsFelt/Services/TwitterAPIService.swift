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
    
    func generateAuthenticationHeaders(api_key: String, api_secret: String) -> [String: String] {
        let credentials = "\(api_key):\(api_secret)".data(using: .utf8)!
        
        let credentialsBase64 = credentials.base64EncodedString(options: [])
        
        return ["Authorization": "Basic \(credentialsBase64)"]
    }
    
    func getBearerToken(api_key: String, api_secret: String, completion: @escaping WebServiceResponse) {

        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_ACCESS_TOKEN.rawValue,
                                httpMethod: .post,
                                parameters: ["grant_type": "client_credentials"],
                                headers: generateAuthenticationHeaders(api_key: api_key, api_secret: api_secret))

        execute(endpoint, completion: completion)
    }
    
    func invalidateBearerToken(api_key: String, api_secret: String, bearerToken: String, completion: @escaping WebServiceResponse) {
        var headers = generateAuthenticationHeaders(api_key: api_key, api_secret: api_secret)
        headers["Accept"] = "*/*"
        
        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_INVALIDATE_TOKEN.rawValue,
                                httpMethod: .post,
                                parameters: ["access_token": "\(bearerToken)"],
                                headers: headers)
        
        execute(endpoint, completion: completion)
    }

}
