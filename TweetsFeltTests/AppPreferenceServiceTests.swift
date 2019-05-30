//
//  AppPreferenceServiceTests.swift
//  TweetsFeltTests
//
//  Created by Randika Vishman on 5/30/19.
//  Copyright © 2019 randika. All rights reserved.
//

import XCTest

@testable import TweetsFelt

class AppPreferenceServiceTests: XCTestCase {

    var sut: TwitterTimelineViewController!
    
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        sut = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? TwitterTimelineViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        super.tearDown()
    }
}
