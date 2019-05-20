//
//  TweetsFeltTests.swift
//  TweetsFeltTests
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import XCTest
import Keys
import ObjectMapper
@testable import TweetsFelt

class TweetsFeltTests: XCTestCase {

    var sut: TwitterAPIService!
    var keys: TweetsFeltKeys!
    
    override func setUp() {
        sut = TwitterAPIService.shared
        keys = TweetsFeltKeys()
    }

    override func tearDown() {
        sut = nil
        keys = nil
    }

    func testBearerTokenSuccess() {
        // 1. given
        let api_key = keys.twitterConsumerAPIKey
        let api_secret = keys.twitterConsumerAPISecret
        
        let promise = expectation(description: "Able to get an Access Token successfully")
        
        // 2. when
        sut.getBearerToken(api_key: api_key, api_secret: api_secret) { (tokenResponseObj, tokenResponseArr, jsonError) in
            // 3. then
            if let error = jsonError {
                XCTFail("Error: \(String(describing: error.error?.localizedDescription))")
                return
            } else if tokenResponseObj != nil {
                if tokenResponseObj!.token_type != nil && tokenResponseObj!.access_token != nil {
                    print("Received Bearer Token: \(tokenResponseObj?.access_token ?? "nil")")
                    XCTAssertEqual(tokenResponseObj!.token_type, "bearer")
                    XCTAssertNotNil(tokenResponseObj!.access_token)
                    promise.fulfill()
                } else {
                    XCTFail("Get Access Token Failed: \(jsonError?.error?.localizedDescription ?? "nil")")
                }
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 8)
    }

    func testBearerTokenFailure() {
        // 1. given
        let api_key = keys.twitterConsumerAPIKey
        let api_secret = "keys.twitterConsumerAPISecret"
        
        let promise = expectation(description: "Get an Access Token won't be succeed")
        
        // 2. when
        sut.getBearerToken(api_key: api_key, api_secret: api_secret) { (tokenResponseObj, tokenResponseArr, jsonError) in
            // 3. then
            if let errors = jsonError?.errors {
                if let firstError = errors.first {
                    XCTAssertEqual(firstError.code, 99, firstError.message ?? "Test Passed - Get Bearer token failed")
                }
                promise.fulfill()
                return
            } else if tokenResponseObj != nil && tokenResponseObj!.token_type != nil {
                print("Was able to get a token with: \(String(describing: tokenResponseObj!.token_type))")
                XCTFail("Was able to get a token with: \(String(describing: tokenResponseObj!.token_type))")
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 8)
    }

    func testFetchUserTimelineSuccess() {
        // 1. given
        let requestParams: [TimelineRequestParams: Any] = sut.getRequestParameters(screen_name: "randikachan")
        
        let promise = expectation(description: "Have at least 1 Tweet in the Timeline for the given screen_name: randikachan")
        
        // 2. when
            sut.fetchUserTimelineFor(requestData: requestParams) { (tweetsObj, tweetsArray, jsonError) in
            
            // 3. then
                if let error = jsonError {
                    XCTFail("Error: \(String(describing: error.error?.localizedDescription))")
                    return
                } else if tweetsArray != nil {
                    if tweetsArray!.count > 1 {
                        print("Tweets Count: \(tweetsArray!.count)")
                        promise.fulfill()
                    } else {
                        XCTFail("Insufficient Tweets Count: \(tweetsArray!.count)")
                    }
                }
            }
        
        // 3. Then
        wait(for: [promise], timeout: 10)
    }
    
    func testUserTimelineNotFound() {
        // 1. given
        let requestParams: [TimelineRequestParams: Any] = sut.getRequestParameters(screen_name: "rasdfandiasdfkachan")
        
        let promise = expectation(description: "Could Not find a Timeline for the screen_name: rasdfandiasdfkachan")
        
        // 2. when
        sut.fetchUserTimelineFor(requestData: requestParams) { (tweetsObj, tweetsArray, jsonError) in
            
            // 3. then
            if let errors = jsonError?.errors {
                if let firstError = errors.first {
                    XCTAssertEqual(firstError.code, 34, firstError.message ?? "Test Passed - Timeline couldn't found for the given screen_name")
                }
                promise.fulfill()
                return
            } else if let response = Mapper<Tweet>().mapArray(JSONObject: tweetsObj) {
                if response.count > 1 {
                    print("Twitter Timeline found with a Tweets Count: \(response.count)")
                    XCTFail("Twitter Timeline found with a Tweets Count: \(response.count)")
                }
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    func testUserTimelineUnAuthorized() {
        // 1. given
        let requestParams: [TimelineRequestParams: Any] = sut.getRequestParameters(screen_name: "rasdfandiasdfkachan")
        
        let promise = expectation(description: "Could Not find a Timeline for the screen_name: rasdfandiasdfkachan")
        
        // 2. when
        sut.fetchUserTimelineFor(requestData: requestParams, bearerToken: "asldfjalsdfj") { (tweetsObj, tweetsArr, jsonError) in
            
            // 3. then
            if let errors = jsonError?.errors {
                if let firstError = errors.first {
                    XCTAssertEqual(firstError.code, 89, firstError.message ?? "Test Passed - Invalid token")
                }
                promise.fulfill()
                return
            } else if let response = Mapper<Tweet>().mapArray(JSONObject: tweetsArr) {
                if response.count > 1 {
                    print("Twitter Timeline found with a Tweets Count: \(response.count)")
                    XCTFail("Twitter Timeline found with a Tweets Count: \(response.count)")
                }
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
