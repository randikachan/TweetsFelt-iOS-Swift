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

    private let enable_logs = false
    
    func execute(_ endpoint: Endpoint, completion: @escaping WebServiceResponse) {
        let urlRequest = endpoint.createRequest()
        
        if self.enable_logs {
            print("Request debugDescription: \(urlRequest.debugDescription)")
        }
        
        urlRequest.validate().responseJSON { response in
            DispatchQueue.main.async {
                if let error = response.error {
                    var responseString: String
                    if response.data != nil {
                        responseString = String(data: response.data!, encoding: String.Encoding.utf8) ?? ""
                        let jsonError = TwitterErrorResponse(JSONString: responseString)
                        jsonError?.error = response.error
                        completion(nil, jsonError)
                    } else {
                        let jsonError = TwitterErrorResponse(JSONString: "")
                        jsonError?.error = response.error
                        completion(nil, jsonError)
                    }
                    
                    if self.enable_logs {
                        print("JSON ERROR: \(error.localizedDescription)")
                    }
                } else if let jsonArray = response.result.value as? [[String: Any]] {
                    completion(jsonArray, nil)
                    
                    if self.enable_logs {
                        print("JSON ARR: \(jsonArray)")
                    }
                } else if let jsonDict = response.result.value as? [String: Any] {
                    completion([jsonDict], nil)
                    if self.enable_logs {
                        print("JSON Dict: \(jsonDict)")
                    }
                }
            }
        }
    }

}
