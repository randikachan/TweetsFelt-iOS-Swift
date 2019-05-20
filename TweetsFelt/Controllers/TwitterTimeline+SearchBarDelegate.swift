//
//  TwitterTimeline+SearchBarDelegate.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import UIKit

extension TwitterTimelineViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        self.tableView.isHidden = true
        self.activityIndicator.isHidden = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.fetchUserTimelineFor(requestData: twitterAPIService.getRequestParameters(screen_name: searchText)) { (tweetObj, tweetsArr, errorResponse) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.isHidden = true
            
            if let tweetsArray = tweetsArr {
                self.searchResultTweetsArr = tweetsArray
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPoint.zero, animated: false)
            } else if errorResponse != nil {
                self.tableView.isHidden = true
                if errorResponse?.errors?[0] != nil {
                    
                } else if errorResponse?.error != nil {
                    print("Search error: " + (errorResponse?.error?.localizedDescription)!)
                }
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
