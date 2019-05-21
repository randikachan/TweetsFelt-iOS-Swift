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
    static let shared = GoogleNaturalLangAPIService()
    
    let keys = TweetsFeltKeys()
    
    func analyzeDocument(document: Parameters, completion: @escaping (GoogleNLSentimentResponse?, [GoogleNLSentimentResponse]?, BaseAPIError?) -> Void) {
        
        var api_key: String
        
        // Check if Google API Key exists or not
        if AppPreferenceService.shared.getGoogleAPIKey() == nil {
            // use Google API Key saved in user defaults
            AppPreferenceService.shared.saveGoogleAPIKey(apiKey: keys.googleWebAPIKey)
            api_key = keys.googleWebAPIKey
        } else {
            api_key = AppPreferenceService.shared.getGoogleAPIKey()!
        }
    
        var headers: [String: String] = [:]
            headers["Accept"] = "*/*"
            headers["Connection"] = "keep-alive"
            headers["Content-Type"] = "application/json"
            headers["Accept-Type"] = "application/json"

        let endpoint = Endpoint(url: URL(string: NetworkConstants.GOOGLE_NLP_API_URL.rawValue)!,
                                path: "\(NetworkConstants.ENDPOINT_DOCUMENT_ANALYZE_SENTIMENT.rawValue)?key=\(api_key)",
                                httpMethod: .post,
                                parameters: document,
                                headers: headers)
    
        execute(endpoint, completion: completion)
    }
}

extension GoogleNaturalLangAPIService {
    
    func generateDocumentRequestData(content: String) -> Parameters {
        let parameters: Parameters = ["document": [
            "type": "PLAIN_TEXT",
            "language": "EN",
            "content": content
            ],
          "encodingType": "UTF8"]
        
        return parameters
    }
}
