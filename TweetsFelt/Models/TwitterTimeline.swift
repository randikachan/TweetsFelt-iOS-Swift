//
//  TwitterTimeline.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class TwitterTimeline: Mappable {
    
    var tweets: [Tweet]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}
