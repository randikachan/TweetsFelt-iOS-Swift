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
    let sentimentEmojisArr: Array<String> = ["😃", "😑", "😟"]
    
    let sadnessContent: String = "I'm really sad, and I feel deep missery!"
    let neutralContent: String = "Fish Dog Ball Circle Car"
    let happinessContent: String = "I'm really glad about us Jane! I think everything will be alright in the end. Look at the bright sky."
    
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
    
    /**
     Give Negative content and the test should pass
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Negative_Success() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.sadnessContent)
        let promise = expectation(description: "Sad Emoji should appear for above given document")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertEqual(sentimentObj.getMood(), self.sentimentEmojisArr[2])
                }

                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    /**
     Give a Netural or Happy Content to this and the test should pass, otherwise fail
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Negative_Failure() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.neutralContent)
        let promise = expectation(description: "Emojies which may appear for above given document should not match")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertNotEqual(sentimentObj.getMood(), self.sentimentEmojisArr[2])
                }
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    /**
     Give Neutral content and the test should pass
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Neutral_Success() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.neutralContent)
        let promise = expectation(description: "Nutral Emoji should appear for above given document")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertEqual(sentimentObj.getMood(), self.sentimentEmojisArr[1])
                }
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    /**
     Give a Happy or Sad Content to this and the test should pass, otherwise fail
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Neutral_Failure() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.happinessContent)
        let promise = expectation(description: "Emojies which may appear for above given document should not match")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertNotEqual(sentimentObj.getMood(), self.sentimentEmojisArr[1])
                }
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    /**
     Give Happy content and the test should pass
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Happiness_Success() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.happinessContent)
        let promise = expectation(description: "Happiness Emoji should appear for above given document")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertEqual(sentimentObj.getMood(), self.sentimentEmojisArr[0])
                }
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }
    
    /**
     Give Sad or Neutral content and the test should pass
     */
    func testGoogleNLP_AnalyzeDocumentSentimentCall_Happiness_Failure() {
        // 1. given
        let documentRequest = sut.generateDocumentRequestData(content: self.neutralContent)
        let promise = expectation(description: "Emojies which may appear for above given document should not match")
        
        // 2. when
        sut.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if baseError != nil {
                XCTFail("Error: \(String(describing: baseError?.googleNLPError!.error?.message))")
                return
            } else if googleSentimentObj != nil {
                print("document magnitude: \(String(describing: googleSentimentObj?.documentSentiment?.magnitude))")
                
                print("document score: \(String(describing: googleSentimentObj?.documentSentiment?.score))")
                
                if let sentimentObj: GoogleNLDocumentSentiment = googleSentimentObj?.documentSentiment {
                    XCTAssertNotEqual(sentimentObj.getMood(), self.sentimentEmojisArr[0])
                }
                
                promise.fulfill()
            }
        }
        
        // 3. Then
        wait(for: [promise], timeout: 5)
    }

}
