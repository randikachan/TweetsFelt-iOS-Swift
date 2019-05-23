//
//  TwitterUser.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class TwitterUser: Mappable {
    
    var userId: Int?
    var userIdStr: String?
    
    var name: String?
    var screen_name: String?
    var location: String?
    var url: URL?
    
    var profile_image_url_https: URL?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userId <- map["id"]
        userIdStr <- map["id_str"]
        name <- map["name"]
        screen_name <- map["screen_name"]
        location <- map["location"]
        url <- map["url"]
        profile_image_url_https <- map["profile_image_url_https"]
    }
}
