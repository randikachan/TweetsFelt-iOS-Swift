//
//  TokenResponse.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenResponse: Mappable {

    var token_type: String?
    var access_token: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        token_type <- map["token_type"]
        access_token <- map["access_token"]
    }
}
