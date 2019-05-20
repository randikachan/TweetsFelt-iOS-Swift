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
    
    func execute<Type>(_ endpoint: Endpoint, completion: @escaping (Type?, [Type]?, BaseAPIError?) -> Void) where Type: BaseMappable
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
                        
                        var baseError: BaseAPIError?
                        
                        if let twitterError = TwitterErrorResponse(JSONString: responseString) {
                            baseError = BaseAPIError(twitterErrorResponse: twitterError, googleNLPErrorResponse: nil)
                            baseError!.error = response.error
                        } else if let googleError = GoogleNLPErrorResponse(JSONString: responseString) {
                            baseError = BaseAPIError(twitterErrorResponse: nil, googleNLPErrorResponse: googleError)
                            baseError!.error = response.error
                        }
                        baseError!.message = response.error?.localizedDescription

                        completion(nil, nil, baseError)
                    } else {
                        let baseError = BaseAPIError(twitterErrorResponse: nil, googleNLPErrorResponse: nil)
                        baseError.error = response.error
                        baseError.message = response.error?.localizedDescription
                        
                        completion(nil, nil, baseError)
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
                    let baseError = BaseAPIError(twitterErrorResponse: nil, googleNLPErrorResponse: nil)
                    baseError.message = "Internal Error"
                    
                    completion(nil, nil, baseError)
                }
            }
        }
    }

}
