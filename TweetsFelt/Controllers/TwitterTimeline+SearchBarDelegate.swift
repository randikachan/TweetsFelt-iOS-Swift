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
        initializeSearchVC()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            setupErrorneousSearchVCWith(statusLabel: "Please enter a valid screen name to view its Timeline!")
            return
        }
        
        viewModel.fetchTwitterTimelineFor(screenName: searchText) { (success) in
            if success {
                self.searchResultTweetsArr = self.viewModel.searchResultTweetsArr ?? []
            } else if let statusMsg = self.viewModel.statusLblText {
                self.setupErrorneousSearchVCWith(statusLabel: statusMsg)
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
    
    // Custom helper methods
    
    // Setup search VC state prior to the search query happens
    func initializeSearchVC() {
        dismissKeyboard()
        self.tableView.isHidden = true
        self.activityIndicator.isHidden = false
        self.statusLbl.text = ""
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Finish up search VC state after a search query
    func setupErrorneousSearchVCWith(statusLabel: String) {
        self.tableView.isHidden = true
        self.activityIndicator.isHidden = true
        self.statusLbl.text = statusLabel
    }

}
