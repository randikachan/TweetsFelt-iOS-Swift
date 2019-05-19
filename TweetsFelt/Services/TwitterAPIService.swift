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
    
    func fetchUserTimelineFor(requestData: [TimelineRequestParams: Any], completion: @escaping WebServiceResponse) {
        
        let bearerToken = "AAAAAAAAAAAAAAAAAAAAANgB%2BgAAAAAA%2FGFWqt%2Fha2t1%2BfwJAgoLxTEEGBQ%3DLK59a8a7Qqm89mSeIHw1UJh0GivM7BYBJdfi0gSJNsDl40H9Vs"
        
        var headers: [String: String] = [:]
            headers["Accept"] = "*/*"
            headers["Connection"] = "close"
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Authorization"] = "Bearer \(bearerToken)"
        
        var parameters: [String: Any] = ["screen_name": requestData[.screen_name] ?? ""]
            parameters["trim_user"] = requestData[.trim_user] ?? true
            parameters["exclude_replies"] = requestData[.exclude_replies] ?? true
            parameters["include_rts"] = requestData[.include_rts] ?? false
            parameters["count"] = requestData[.count] ?? 20
        
        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_USER_TIMELINE_STATUSES.rawValue,
                                httpMethod: .get,
                                parameters: parameters,
                                headers: headers)
        
        execute(endpoint, completion: completion)
    }

}
