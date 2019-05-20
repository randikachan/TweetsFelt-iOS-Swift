//
//  GoogleNLPError.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 // Following is an example of structured JSON Twitter Error response
 
 {
     "error": {
         "code": 403,
         "message": "Cloud Natural Language......",
         "status": "PERMISSION_DENIED",
         "details": []
     }
 }
 */

class GoogleNLPError: Mappable {
    
    var status: String?
    var code: Int?
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
}

class GoogleNLPErrorResponse: Mappable {
    
    var error: GoogleNLPError?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        error <- map["error"]
    }
}
