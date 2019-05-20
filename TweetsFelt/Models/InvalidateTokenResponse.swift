//
//  InvalidateTokenResponse.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class InvalidateTokenResponse: Mappable {

    var access_token: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
    }
}
