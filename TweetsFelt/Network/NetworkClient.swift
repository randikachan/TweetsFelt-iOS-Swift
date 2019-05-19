//
//  NetworkClient.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient: NetworkProtocol {

    func execute(_ httpMethod: HTTP_VERB, url: URL, completion: @escaping WebServiceResponse) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        Alamofire.request(url).validate().responseJSON { response in
            DispatchQueue.main.async {
                if let error = response.error {
                    completion(nil, error)
                } else if let jsonArray = response.result.value as? [[String: Any]] {
                    completion(jsonArray, nil)
                } else if let jsonDict = response.result.value as? [String: Any] {
                    completion([jsonDict], nil)
                }
            }
        }
    }

}
