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
    private var searchText: String?
    
    var searchResultTweetsArr: [Tweet]?

    var error: BaseAPIError? {
        didSet {
            self.decodeErrorMsg()
        }
    }

    var isLoading: Bool = false
    
    var statusLblText: String?
    
    // MARK - Constructor
    init() {
        self.decodeErrorMsg()
    }
}

// MARK: - Network call
extension TwitterTimelineVCViewModel {
    
    func initializeAPIToken(completion: @escaping () -> Void) {
        // Check if Bearer token exists or not
        if AppPreferenceService.shared.getBearerToken() == nil {
            self.isLoading = true
            // If not get Bearer token and save it
            let twitterAPIService = TwitterAPIService.shared
            twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (tokenObject, tokenArr, errorResponse) in
                self.isLoading = false
                
                print("completed: \(String(describing: tokenObject?.toJSONString()))")
                
                // Save bearer token for later use
                if let token = tokenObject?.access_token {
                    AppPreferenceService.shared.saveBearerToken(bearerToken: token)
                } else if let baseError = errorResponse {
                    self.error = baseError
                }
                
                completion()
            }
        } else {
            self.isLoading = false
            completion()
        }
    }
    
    func fetchTwitterTimelineFor(screenName: String, completion: @escaping (Bool) -> Void) {
        // Fetch Twitter timeline for the given screenname
        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.fetchUserTimelineFor(requestData: twitterAPIService.getRequestParameters(screen_name: screenName)) { (tweetObj, tweetsArr, errorResponse) in
            // Clear out the Search VC
            // self.setupErrorneousSearchVCWith(statusLabel: "")
            
            if let tweetsArray = tweetsArr {
                self.searchResultTweetsArr = tweetsArray
                completion(true)
            } else if let baseError = errorResponse {
                self.error = baseError
                completion(false)
            }
        }
    }
}

// Need to validate the idea of such a list of following Protocol methods for Interface Segration principal
extension TwitterTimelineVCViewModel: TwitterTimelineNetworkProtocol {
    func onErrorShowAlert(error: BaseAPIError) { }
    
    func onErrorShowAlert(error: BaseAPIError, errorLabel: UILabel) { }
    
    func updateLoadingStatus() { }
    
    func didFinishGetBearerToken() { }
    
    func didFinishFetchTwitterTimelin(tweetsArr: [Tweet]) { }

}

extension TwitterTimelineVCViewModel {
 
    func decodeErrorMsg() {
        if let errorMessage = self.error?.googleNLPError?.error?.message {
            self.statusLblText = errorMessage
            return
        } else if let errorMessage = self.error?.twitterError?.errors![0].message {
            self.statusLblText = errorMessage
            return
        } else if let error = self.error?.error {
            print("Localized Error: " + (error.localizedDescription))
            self.statusLblText = error.localizedDescription
            return
        }
        
        self.statusLblText = "Search for a Twitter Screen Name to View and Feel its Timeline!"
    }
}
