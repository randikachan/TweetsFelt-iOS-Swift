//
//  BaseAPIError.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class BaseAPIError {
    
    var twitterError: TwitterErrorResponse?
    var googleNLPError: GoogleNLPErrorResponse?
    var error: Error?
    var message: String?
    
    init(twitterErrorResponse: TwitterErrorResponse?, googleNLPErrorResponse: GoogleNLPErrorResponse?) {
        self.twitterError = twitterErrorResponse
        self.googleNLPError = googleNLPErrorResponse
    }
}
