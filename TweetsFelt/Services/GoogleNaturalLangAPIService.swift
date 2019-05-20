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
    
    func analyzeDocument(documentRequest: GoogleNLPDocumentRequest, completion: @escaping (GoogleNLSentimentResponse?, [GoogleNLSentimentResponse]?, BaseAPIError?) -> Void) {
        
        // use bearer token saved in user defaults
        AppPreferenceService.shared.saveGoogleAPIKey(apiKey: "AIzaSyD3EpwfjzSk5Go_d-A_AmxvDGH4sWMI_I0")
        let api_key: String = AppPreferenceService.shared.getGoogleAPIKey()!
    
        var headers: [String: String] = [:]
            headers["Accept"] = "*/*"
            headers["Connection"] = "keep-alive"
            headers["Content-Type"] = "application/json"
            headers["accept-encoding"] = "gzip, deflate"
    
        let scheme = "https"
        let host = NetworkConstants.GOOGLE_NLP_API_URL.rawValue
        let path = NetworkConstants.ENDPOINT_DOCUMENT_ANALYZE_SENTIMENT.rawValue
        let queryItem = URLQueryItem(name: "key", value: api_key)
        
        var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = [queryItem]
        
        print(urlComponents.url)
        if let url = urlComponents.url {
            
        }
        
        let endpoint = Endpoint(url: urlComponents.url!,
                                path: "",
                                httpMethod: .post,
                                parameters: [:],
                                headers: headers)
    
        execute(endpoint, completion: completion)
    }
}
