//
//  TwitterError.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper
/**
 // Following is an example of structured JSON Twitter Error response

 {
     "error": [
         {
             "code": 348,
             "message": "Client application is not permitted to to invalidate this token."
         }
     ]
 }
 */

class TwitterError: Mappable {
    
    var code: Int?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        code    <- map["code"]
        message <- map["message"]
    }
}

class TwitterErrorResponse: Mappable {
    
    var errors: [TwitterError]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        errors <- map["errors"]
    }
}
