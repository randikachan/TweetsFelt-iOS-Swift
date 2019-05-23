//
//  TwitterTimelineVCModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterTimelineVCModel {
    
    public let searchText: String
    public var searchResultTweetsArr: [Tweet]   // subjected to change during the course of lifecycle of the VC
    
    public init(searchText: String, tweetsArr: [Tweet]) {
        self.searchText = searchText
        self.searchResultTweetsArr = tweetsArr
    }
}
