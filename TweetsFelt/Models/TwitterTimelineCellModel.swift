//
//  TwitterTimelineCellModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterTimelineCellModel {
    
    let text: String
    let sentiment: GoogleNLDocumentSentiment
    
    init(tweetText: String, sentiment: GoogleNLDocumentSentiment) {
        self.text = tweetText
        self.sentiment = sentiment
    }
}
