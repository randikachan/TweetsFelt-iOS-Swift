//
//  TweetsFeltTests.swift
//  TweetsFeltTests
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import TweetsFelt

class TweetsFeltTests: XCTestCase {

    var sut: TwitterAPIService!
    
    override func setUp() {
        sut = TwitterAPIService.shared
    }

    override func tearDown() {
        sut = nil
    }

    func testFetchUserTimelineSuccess() {
        // 1. given
        var requestParams: [TimelineRequestParams: Any] = [.screen_name : "randikachan"]
            requestParams[.trim_user] = true        // Send less user details
            requestParams[.exclude_replies] = true  // Exclude Reply tweets
            requestParams[.include_rts] = false     // Except Retweets
            requestParams[.count] = 20               // out of first 20 tweets
        
        let promise = expectation(description: "Have at least 1 Tweet in the Timeline for the given screen_name: randikachan")
        
        // 2. when
            sut.fetchUserTimelineFor(requestData: requestParams) { (json, jsonError) in
            
            // 3. then
                if let error = jsonError {
                    XCTFail("Error: \(error.error?.localizedDescription)")
                    return
                } else if let response = Mapper<Tweet>().mapArray(JSONObject: json) {
                    if response.count > 1 {
                        print("Tweets Count: \(response.count)")
                        promise.fulfill()
                    } else {
                        XCTFail("Insufficient Tweets Count: \(response.count)")
                    }
                }
            }
        
        // 3
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
