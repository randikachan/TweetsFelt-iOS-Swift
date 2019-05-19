//
//  TwitterService.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Alamofire
import Keys

class TwitterAPIService : NetworkClient {
    
    // MARK: - Singleton
    static let shared = TwitterAPIService()
    
    let keys = TweetsFeltKeys()
    
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
    
    func fetchUserTimelineFor(screen_name: String, bearerToken: String, completion: @escaping WebServiceResponse) {
        
        var headers: [String: String] = [:]
            headers["Accept"] = "*/*"
            headers["Connection"] = "close"
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Authorization"] = "Bearer \(bearerToken)"
        
        var parameters: [String: Any] = ["screen_name": screen_name]
            parameters["trim_user"] = true
            parameters["exclude_replies"] = true
            parameters["include_rts"] = false
            parameters["count"] = 20
        
        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_USER_TIMELINE_STATUSES.rawValue,
                                httpMethod: .get,
                                parameters: parameters,
                                headers: headers)
        
        execute(endpoint, completion: completion)
    }

}
