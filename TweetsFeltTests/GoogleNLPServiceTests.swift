//
//  GoogleNLPServiceTests.swift
//  TweetsFeltTests
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import XCTest
import Keys
import ObjectMapper
@testable import TweetsFelt

class GoogleNLPServiceTests: XCTestCase {

    var sut: GoogleNaturalLangAPIService!
    var keys: TweetsFeltKeys!
    
    override func setUp() {
        sut = GoogleNaturalLangAPIService.shared
        keys = TweetsFeltKeys()
    }

    override func tearDown() {
        sut = nil
        keys = nil
    }

    func testGoogleNLP_AnalyzeDocumentSentimentCall() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: "Damn! Why I had to sit next to this guy who watches YouTube videos on youtube mobile site using Safari browser on an iPhone 8? 😳😣😖😒☹️")
        let promise = expectation(description: "Able to get Sentiment Analyzed successfully")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                XCTAssertGreaterThan((googleSentimentObj?.documentSentiment?.magnitude)!, 0.1)
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                XCTAssertLessThan((googleSentimentObj?.documentSentiment?.score)!, -0.1)
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }

}
