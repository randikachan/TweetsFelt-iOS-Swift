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

    func execute(_ endpoint: Endpoint, completion: @escaping WebServiceResponse) {
        let urlRequest = endpoint.createRequest()
        
        urlRequest.validate().responseJSON { response in
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
