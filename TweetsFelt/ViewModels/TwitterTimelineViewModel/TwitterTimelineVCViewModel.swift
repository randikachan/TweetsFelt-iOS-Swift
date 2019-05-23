//
//  TwitterTimelineVCViewModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import Keys

class TwitterTimelineVCViewModel {

    let keys = TweetsFeltKeys()
    
    // MARK: - Properties
    private var searchText: String? {
        didSet {
            guard let searchString = searchText else { return }
            self.fetchTwitterTimelineFor(screenName: searchString)
        }
    }
    private var searchResultTweetsArr: [Tweet]? {
        didSet {
            guard let tweetsArr = searchResultTweetsArr else { return }
            self.didFinishFetchTwitterTimelin(tweetsArr: tweetsArr)
        }
    }

    var error: BaseAPIError? {
        didSet {
            guard let err = error else { return }
            self.onErrorShowAlert(error: err)
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus()
        }
    }
    
    // MARK: - Constructor
    init() {
        self.initializeAPIToken()
    }
    
}

// MARK: - Network call
extension TwitterTimelineVCViewModel {
    
    func initializeAPIToken() {
        // Check if Bearer token exists or not
        if AppPreferenceService.shared.getBearerToken() == nil {
            // If not get Bearer token and save it
            let twitterAPIService = TwitterAPIService.shared
            twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (tokenObject, tokenArr, jsonError) in
                print("completed: \(String(describing: tokenObject?.toJSONString()))")
                // self.activityIndicator.isHidden = true
                
                // Save bearer token for later use
                if let token = tokenObject?.access_token {
                    AppPreferenceService.shared.saveBearerToken(bearerToken: token)
                }
                // self.activityIndicator.isHidden = true
            }
        } else {
            // self.activityIndicator.isHidden = true
        }
    }
    
    func fetchTwitterTimelineFor(screenName: String) {
        // Fetch Twitter timeline for the given screenname
        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.fetchUserTimelineFor(requestData: twitterAPIService.getRequestParameters(screen_name: screenName)) { (tweetObj, tweetsArr, errorResponse) in
            // Clear out the Search VC
            // self.setupErrorneousSearchVCWith(statusLabel: "")
            
            if let tweetsArray = tweetsArr {
                // self.tableView.isHidden = false
                self.searchResultTweetsArr = tweetsArray
            } else if errorResponse != nil {
                if let errorMessage = errorResponse?.twitterError?.errors![0].message {
                    // self.setupErrorneousSearchVCWith(statusLabel: errorMessage)
                } else if errorResponse?.error != nil {
                    print("Search error: " + (errorResponse?.error?.localizedDescription)!)
                    // self.setupErrorneousSearchVCWith(statusLabel: (errorResponse?.error?.localizedDescription)!)
                }
            }
        }
    }
}

extension TwitterTimelineVCViewModel: TwitterTimelineNetworkProtocol {
    func onErrorShowAlert(error: BaseAPIError) {
        
    }
    
    func updateLoadingStatus() {
        
    }
    
    func didFinishGetBearerToken() {
        
    }
    
    func didFinishFetchTwitterTimelin(tweetsArr: [Tweet]) {
        
    }

}
