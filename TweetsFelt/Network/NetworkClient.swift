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
        
        // print("Request debugDescription: \(urlRequest.debugDescription)")
        
        urlRequest.validate().responseJSON { response in
            DispatchQueue.main.async {
                if let error = response.error {
                    completion(nil, error)
                    print("JSON ERROR: \(error.localizedDescription)")
                } else if let jsonArray = response.result.value as? [[String: Any]] {
                    completion(jsonArray, nil)
                    print("JSON ARR: \(jsonArray)")
                } else if let jsonDict = response.result.value as? [String: Any] {
                    completion([jsonDict], nil)
                    print("JSON Dict: \(jsonDict)")
                }
            }
        }
    }

}
