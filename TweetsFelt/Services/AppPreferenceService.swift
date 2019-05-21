//
//  AppPreferences.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class AppPreferenceService {
    
    // MARK: - Singleton
    static let shared = AppPreferenceService()
    let defaults = UserDefaults.standard
    
    // Twitter Bearer Token API
    func saveBearerToken(bearerToken: String) {
        defaults.set(bearerToken, forKey: AppPreferenceKeys.bearerToken.rawValue)
        defaults.synchronize()
    }
    
    func getBearerToken() -> String? {
        return defaults.string(forKey: AppPreferenceKeys.bearerToken.rawValue)
    }
    
    func removeBearerToken() {
        defaults.removeObject(forKey: AppPreferenceKeys.bearerToken.rawValue)
        defaults.synchronize()
    }
    
    // Google API Preferences
    func saveGoogleAPIKey(apiKey: String) {
        defaults.set(apiKey, forKey: AppPreferenceKeys.googleAPIKey.rawValue)
        defaults.synchronize()
    }
    
    func getGoogleAPIKey() -> String? {
        return defaults.string(forKey: AppPreferenceKeys.googleAPIKey.rawValue)
    }
    
    func removeGetGoogleAPIKey() {
        defaults.removeObject(forKey: AppPreferenceKeys.googleAPIKey.rawValue)
        defaults.synchronize()
    }
    
    // Settings Screen Preferences
    func saveAvoidReplyTweets(avoidReplyTweets: Bool) {
        defaults.set(avoidReplyTweets, forKey: AppPreferenceKeys.avoidReplyTweets.rawValue)
        defaults.synchronize()
    }
    
    func getAvoidReplyTweets() -> Bool? {
        return defaults.bool(forKey: AppPreferenceKeys.avoidReplyTweets.rawValue)
    }
    
    func saveAvoidReTweets(avoidReTweets: Bool) {
        defaults.set(avoidReTweets, forKey: AppPreferenceKeys.avoidReTweets.rawValue)
        defaults.synchronize()
    }
    
    func getAvoidReTweets() -> Bool? {
        return defaults.bool(forKey: AppPreferenceKeys.avoidReTweets.rawValue)
    }
    
    func saveFetchTweetsCount(count: Int) {
        defaults.set(count, forKey: AppPreferenceKeys.tweetsCount.rawValue)
        defaults.synchronize()
    }
    
    func getFetchTweetsCount() -> Int? {
        return defaults.integer(forKey: AppPreferenceKeys.tweetsCount.rawValue)
    }

}
