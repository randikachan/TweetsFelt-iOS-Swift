//
//  TwitterTimelineViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import UIKit
import Keys
import ObjectMapper
import Alamofire

class TwitterTimelineViewController: UIViewController {
    
    let keys = TweetsFeltKeys()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var statusLbl: UILabel!
    
    var searchResultTweetsArr: [Tweet] = []
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the TableViewCell Nib files
        let tableViewCellNib: UINib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "tweetCell")
        
        let tableViewHeaderCellNib: UINib = UINib(nibName: "TimelineHeaderTableViewCell", bundle: nil)
        self.tableView.register(tableViewHeaderCellNib, forCellReuseIdentifier: "timelineHeaderCell")
        
        // Setup initial Search View UI state
        activityIndicator.isHidden = false
        tableView.isHidden = true
        self.statusLbl.text = "Search for a Twitter Screen Name to View and Feel its Timeline!"
        
        // Check if Bearer token exists or not
        if AppPreferenceService.shared.getBearerToken() == nil {
            // If not get Bearer token and save it
            let twitterAPIService = TwitterAPIService.shared
            twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (tokenObject, tokenArr, jsonError) in
                print("completed: \(String(describing: tokenObject?.toJSONString()))")
                self.activityIndicator.isHidden = true
                
                // Save bearer token for later use
                if let token = tokenObject?.access_token {
                    AppPreferenceService.shared.saveBearerToken(bearerToken: token)
                }
                self.activityIndicator.isHidden = true
            }
        } else {
            self.activityIndicator.isHidden = true
        }
    }
}

// MARK: - UITableView

extension TwitterTimelineViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultTweetsArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.configureCellFor(tweet: self.searchResultTweetsArr[indexPath.item], delegate: self, tag: indexPath.item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // This will turn on `masksToBounds` before the cell is displayed
        cell.contentView.layer.masksToBounds = true
        
        // for smooth scrolling
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Custom UITableViewCell Delegate

extension TwitterTimelineViewController: AnalyzeTweetContentCellDelegate {
    
    func analyzeDocumentSentimentAndUpdate(_ cell: TweetTableViewCell) {
        if let tweetTextContent = cell.tweetTextLbl.text {
            // Activity Indicator
            cell.activityIndicator.isHidden = false
            
            // Prepare the document and the API call
            let googleAPIService = GoogleNaturalLangAPIService.shared
            let documentRequest = googleAPIService.generateDocumentRequestData(content: tweetTextContent)
            
            googleAPIService.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
                // Hide the activity Indicator
                
                cell.activityIndicator.isHidden = true
                if googleSentimentObj != nil {
                    self.searchResultTweetsArr[cell.tag].sentiment = googleSentimentObj?.documentSentiment
                    cell.sentimentThumbLbl.text = googleSentimentObj?.documentSentiment?.getMood()
                } else if baseError != nil {
                    cell.sentimentThumbLbl.text = "⁉️"
                }
            }
        }
    }
}
