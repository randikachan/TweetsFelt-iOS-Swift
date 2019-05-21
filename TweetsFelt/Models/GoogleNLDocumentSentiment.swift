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
    
    let sentimentEmojisArr: Array<String> = ["😃", "😑", "😟"]
    
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
    
    public func getMood() -> String {
        if let sentimentScore: Float = score, let sentimentMagnitude: Float = magnitude {
            if -1 ... 0.0 ~= sentimentScore && sentimentMagnitude > 0.0 {
                return sentimentEmojisArr[2]    // Sadness
            } else if 0.0 ~= sentimentScore && 0.0 ~= sentimentMagnitude {
                return sentimentEmojisArr[1]    // Nutral
            } else if 00 ... 1 ~= sentimentScore && sentimentMagnitude > 0.0 {
                return sentimentEmojisArr[0]    // Happiness
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
