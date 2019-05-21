//
//  Tweet.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class Tweet: Mappable {
    
    var tweetId: Int?
    var tweetIdStr: String?
    
    var text: String?
    var user: TwitterUser?
    
    var sentiment: GoogleNLDocumentSentiment?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tweetId <- map["id"]
        tweetIdStr <- map["id_str"]

        text <- map["text"]
        user <- map["user"]
    }
}

