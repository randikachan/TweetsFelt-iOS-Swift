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
    
    let sentimentEmojisArr: Array<String> = ["😃", "😐", "😟"]
    
    var magnitude: Float?
    var score: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        magnitude <- map["magnitude"]
        score <- map["score"]
    }
}

extension GoogleNLDocumentSentiment {
    
    func getMood() -> String {
        if let sentimentScore: Float = score, let sentimentMagnitude: Float = magnitude {
            if 0.0 ... 1 ~= sentimentScore && sentimentMagnitude > 0.0 {
                return sentimentEmojisArr[0]
            } else if 0.0 ... 0.9 ~= sentimentScore && 0.0 ... 1 ~= sentimentMagnitude {
                return sentimentEmojisArr[1]
            } else if -1 ... 0.0 ~= sentimentScore && sentimentMagnitude > 0.0 {
                return sentimentEmojisArr[2]
            }
        }
        
        return ""
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
