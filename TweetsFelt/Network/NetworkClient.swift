//
//  NetworkClient.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class NetworkClient: NetworkProtocol {

    private let enable_logs = false
    
    func execute<Type>(_ endpoint: Endpoint, completion: @escaping (Type?, [Type]?, TwitterErrorResponse?) -> Void) where Type: BaseMappable
    {
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
                        completion(nil, nil, jsonError)
                    } else {
                        let jsonError = TwitterErrorResponse(JSONString: "")
                        jsonError?.error = response.error
                        completion(nil, nil, jsonError)
                    }
                    
                    if self.enable_logs {
                        print("JSON ERROR: \(error.localizedDescription)")
                    }
                } else if let jsonArray = response.result.value as? [Any] {
                    let objectArray = Mapper<Type>().mapArray(JSONObject: jsonArray)
                    completion(nil, objectArray, nil)
                    
                    if self.enable_logs {
                        print("JSON ARR: \(jsonArray)")
                    }
                } else if let jsonObject = response.result.value as? Dictionary<String, Any> {
                    let decodedObject = Mapper<Type>().map(JSONObject: jsonObject)
                    completion(decodedObject, nil, nil)
                    
                    if self.enable_logs {
                        print("JSON ARR: \(String(describing: decodedObject))")
                    }
                } else {
                    print("response.result.value: \(String(describing: response.result.value))")
                    let jsonError = TwitterErrorResponse(JSONString: "")
                    let webAPIError = TwitterError(JSONString: "")
                    
                    webAPIError?.message = "Internal Error"
                    jsonError!.errors?.append(webAPIError!)
                    completion(nil, nil, jsonError)
                }
            }
        }
    }

}
