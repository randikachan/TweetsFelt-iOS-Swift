//
//  TwitterTimelineVCViewModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterTimelineVCViewModel {
    
    private let timeline: TwitterTimelineVCModel    // Not the API Model
    
    public init(timeline: TwitterTimelineVCModel) {
        self.timeline = timeline
    }
    
    public var searchString: String {
        return timeline.searchText
    }
    
    public var twitterTimeline: [Tweet] {
        return timeline.searchResultTweetsArr
    }
}
