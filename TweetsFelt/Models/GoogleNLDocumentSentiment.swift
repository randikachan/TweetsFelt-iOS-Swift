//
//  GoogleNLDocumentSentiment.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

class GoogleNLDocumentSentiment: Mappable {
    
    var magnitude: Float?
    var score: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        magnitude <- map["magnitude"]
        score <- map["score"]
    }
}

class GoogleNLSentimentResponse: Mappable {
    
    var documentSentiment: GoogleNLDocumentSentiment?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        documentSentiment <- map["documentSentiment"]
    }
}
