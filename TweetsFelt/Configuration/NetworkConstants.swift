//
//  NetworkConstants.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

enum NetworkConstants: String {
    // URLs
    case TWITTER_API_URL = "https://api.twitter.com/"
    case GOOGLE_NLP_API_URL = "https://language.googleapis.com/"
    
    // Twitter Endpoints
    case ENDPOINT_ACCESS_TOKEN = "oauth2/token"
    case ENDPOINT_INVALIDATE_TOKEN = "oauth2/invalidate_token"
    case ENDPOINT_USER_TIMELINE_STATUSES = "1.1/statuses/user_timeline.json"
    
    // Google Endpoints
    case ENDPOINT_DOCUMENT_ANALYZE_SENTIMENT = "v1/documents:analyzeSentiment"
}
