//
//  GoogleNLPDocument.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class GoogleNLPDocument: Mappable {
    
    var type: String?
    var language: String?
    var content: String?
    var encodingType: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        language <- map["language"]
        content <- map["content"]
        encodingType <- map["encodingType"]
    }
}

class GoogleNLPDocumentRequest: Mappable {

    var document: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        document <- map["document"]
    }
}
