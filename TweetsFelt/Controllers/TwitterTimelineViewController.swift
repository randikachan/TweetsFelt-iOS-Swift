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
    let sentimentEmojisArr: Array<String> = ["😃", "😐", "😟"]
    
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
        
        let googleAPIService = GoogleNaturalLangAPIService.shared

        let documentRequest: Parameters = ["document": [
            "type": "PLAIN_TEXT",
            "language": "EN",
            "content": "Damn! Why I had to sit next to this guy who watches YouTube videos on youtube mobile site using Safari browser on an iPhone 8? 😳😣😖😒☹️ It’s fcuking annoying!"
            ],
                                              "encodingType": "UTF8"]
        
        googleAPIService.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
            if googleSentimentObj != nil {
                print("document magnitude: \(googleSentimentObj?.documentSentiment?.magnitude)")
                print("document score: \(googleSentimentObj?.documentSentiment?.score)")
            } else if baseError != nil {
                print("analyzeDocument Error: \(baseError?.googleNLPError)")
                print("analyzeDocument Error: \(baseError?.error?.localizedDescription)")
            }
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
        
        // At this point, the didSet block will set up the cell's views
        cell.sentimentThumbLbl.text = sentimentEmojisArr[0]
        cell.sentimentThumbLbl.backgroundColor = UIColor.clear
        
        cell.tweetTextLbl.backgroundColor = UIColor.clear
        cell.tweetTextLbl.text = self.searchResultTweetsArr[indexPath.item].text
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7458261986)
        
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // This will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        
        // for smooth scrolling
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
