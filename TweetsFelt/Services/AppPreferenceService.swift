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
}
