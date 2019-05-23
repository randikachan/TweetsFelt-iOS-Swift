//
//  TwitterTimelineCellViewModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterTimelineCellViewModel {
    
    private let sentimentThumbLblText: String
    private let tweetTextLblText: String
    private let isActivityIndicatorShown: Bool
    
    public init(sentimentEmoji: String, tweetText: String, isBusy: Bool) {
        self.sentimentThumbLblText = sentimentEmoji
        self.tweetTextLblText = tweetText
        self.isActivityIndicatorShown = isBusy
    }
    
}
