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
import ObjectMapper

class TwitterAPIService : NetworkClient {
    
    // MARK: - Singleton
    static let shared = TwitterAPIService()
    
    let keys = TweetsFeltKeys()
    
    func getBearerToken(api_key: String, api_secret: String, completion: @escaping (TokenResponse?, [TokenResponse]?, TwitterErrorResponse?) -> Void) {

        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_ACCESS_TOKEN.rawValue,
                                httpMethod: .post,
                                parameters: ["grant_type": "client_credentials"],
                                headers: generateAuthenticationHeaders(api_key: api_key, api_secret: api_secret))

        execute(endpoint, completion: completion)
    }
    
    func invalidateBearerToken(api_key: String, api_secret: String, bearerToken: String, completion: @escaping (InvalidateTokenResponse?, [InvalidateTokenResponse]?, TwitterErrorResponse?) -> Void) {
        
        var headers = generateAuthenticationHeaders(api_key: api_key, api_secret: api_secret)
        headers["Accept"] = "*/*"
        
        let endpoint = Endpoint(url: URL(string: NetworkConstants.TWITTER_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_INVALIDATE_TOKEN.rawValue,
                                httpMethod: .post,
                                parameters: ["access_token": "\(bearerToken)"],
                                headers: headers)
        
        execute(endpoint, completion: completion)
    }
    
    func fetchUserTimelineFor(requestData: [TimelineRequestParams: Any], bearerToken: String?, completion: @escaping (Tweet?, [Tweet]?, TwitterErrorResponse?) -> Void) {
        var localBearerToken: String
        if bearerToken == nil {
            // TODO: Storing Bearer Token in NSUsserDefaults/Key-chain is not yet implemented
            localBearerToken = "AAAAAAAAAAAAAAAAAAAAANgB%2BgAAAAAA%2FGFWqt%2Fha2t1%2BfwJAgoLxTEEGBQ%3DLK59a8a7Qqm89mSeIHw1UJh0GivM7BYBJdfi0gSJNsDl40H9Vs"
        } else {
            localBearerToken = bearerToken!
        }
        
        var headers: [String: String] = [:]
        headers["Accept"] = "*/*"
        headers["Connection"] = "close"
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        headers["Authorization"] = "Bearer \(localBearerToken)"
        
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
    
    func fetchUserTimelineFor(requestData: [TimelineRequestParams: Any], completion: @escaping (Tweet?, [Tweet]?, TwitterErrorResponse?) -> Void) {
        fetchUserTimelineFor(requestData: requestData, bearerToken: nil, completion: completion)
    }

}

extension TwitterAPIService {
    
    func generateAuthenticationHeaders(api_key: String, api_secret: String) -> [String: String] {
        let credentials = "\(api_key):\(api_secret)".data(using: .utf8)!
        
        let credentialsBase64 = credentials.base64EncodedString(options: [])
        
        return ["Authorization": "Basic \(credentialsBase64)"]
    }
    
    func getRequestParameters(screen_name: String) -> [TimelineRequestParams: Any] {
        return getRequestParameters(screen_name: screen_name, trim_user: true, exclude_reply_tweets: true, include_retweets: false, number_of_tweets_to_fetch: 20)
    }
    
    func getRequestParameters(screen_name: String, trim_user: Bool = true, exclude_reply_tweets: Bool = true, include_retweets: Bool = false, number_of_tweets_to_fetch: Int = 20) -> [TimelineRequestParams: Any] {
        var requestParams: [TimelineRequestParams: Any] = [.screen_name : screen_name]
        requestParams[.trim_user] = true        // Send less user details
        requestParams[.exclude_replies] = true  // Exclude Reply tweets
        requestParams[.include_rts] = true     // Except Retweets
        requestParams[.count] = 20               // out of first 20 tweets
        
        return requestParams;
    }

}
