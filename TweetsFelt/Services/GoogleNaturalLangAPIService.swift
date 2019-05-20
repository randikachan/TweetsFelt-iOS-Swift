//
//  GoogleNaturalLangAPIService.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Alamofire
import Keys
import ObjectMapper

class GoogleNaturalLangAPIService: NetworkClient {

    // MARK: - Singleton
    static let shared = TwitterAPIService()
    
    let keys = TweetsFeltKeys()
    
    func analyzeDocument(documentRequest: GoogleNLPDocumentRequest, completion: @escaping (GoogleNLSentimentResponse?, [GoogleNLSentimentResponse]?, GoogleNLPError?) -> Void) {
        
        // use bearer token saved in user defaults
        var api_key: String = AppPreferenceService.shared.getBearerToken()!
    
        var headers: [String: String] = [:]
            headers["Accept"] = "*/*"
            headers["Connection"] = "keep-alive"
            headers["Content-Type"] = "application/json"
            headers["accept-encoding"] = "gzip, deflate"
    
        var parameters: [String: Any] = ["key": api_key]
    
        let endpoint = Endpoint(url: URL(string: NetworkConstants.GOOGLE_NLP_API_URL.rawValue)!,
                                path: NetworkConstants.ENDPOINT_DOCUMENT_ANALYZE_SENTIMENT.rawValue,
                                httpMethod: .post,
                                parameters: parameters,
                                headers: headers)
    
//        execute(endpoint, completion: completion)
    }
}
