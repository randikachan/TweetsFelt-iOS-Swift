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

extension GoogleNLDocumentSentiment {
    
    public func getMood() -> String {
        
        let positiveScoreRange: ClosedRange<Float> = 0.1 ... 1
        
        let negativeScoreRange: ClosedRange<Float> = -1 ... -0.1
        
        let neutralScoreRange: ClosedRange<Float> = -0.09 ... 0.09
        
        let commonMagnitudeRange: ClosedRange<Float> = 0.0 ... .infinity  // Too negative content when combined with above negatvie Score Range
        
        if let sentimentScore: Float = score, let sentimentMagnitude: Float = magnitude {
            if negativeScoreRange.contains(sentimentScore) && commonMagnitudeRange.contains(sentimentMagnitude) {
                return Emojies.sadnessEmoji.rawValue    // Sadness
            } else if neutralScoreRange.contains(sentimentScore) || sentimentMagnitude ~= 0.0 {
                return Emojies.neutralEmoji.rawValue    // Nutral
            } else if positiveScoreRange.contains(sentimentScore) && commonMagnitudeRange.contains(sentimentMagnitude) {
                return Emojies.happinessEmoji.rawValue    // Happiness
            }
        }
        
        return "⁉️"
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
