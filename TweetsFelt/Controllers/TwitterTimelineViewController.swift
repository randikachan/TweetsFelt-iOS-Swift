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

class TwitterTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let keys = TweetsFeltKeys()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var tweetsArr: [Tweet] = []
    let sentimentEmojisArr: Array<String> = ["😃", "😐", "😟"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewCellNib: UINib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "tweetCell")
        
        let tableViewHeaderCellNib: UINib = UINib(nibName: "TimelineHeaderTableViewCell", bundle: nil)
        self.tableView.register(tableViewHeaderCellNib, forCellReuseIdentifier: "timelineHeaderCell")
        
        activityIndicator.isHidden = false
        tableView.isHidden = true

        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (tokenObject, tokenArr, jsonError) in
            print("completed: \(String(describing: tokenObject?.toJSONString()))")
            self.activityIndicator.isHidden = true
            
            if let token = tokenObject?.access_token {
                AppPreferenceService.shared.saveBearerToken(bearerToken: token)
            }
        }
        
        twitterAPIService.fetchUserTimelineFor(requestData: twitterAPIService.getRequestParameters(screen_name: "randikachan")) { (tweetObj, tweetsArr, jsonError) in
            self.activityIndicator.isHidden = true
            self.tableView.isHidden = false
            
            self.tweetsArr = tweetsArr!
            self.tableView.reloadData()
        }
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetsArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        // At this point, the didSet block will set up the cell's views
        cell.sentimentThumbLbl.text = sentimentEmojisArr[0]
        cell.sentimentThumbLbl.backgroundColor = UIColor.clear
        
        cell.tweetTextLbl.backgroundColor = UIColor.clear
        cell.tweetTextLbl.text = self.tweetsArr[indexPath.item].text
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7458261986)
        
        cell.clipsToBounds = true
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelineHeaderCell") as! TimelineHeaderTableViewCell
        
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
//        let selectedCountry: Country = self.countriesArr[indexPath.row]
//        print("\(selectedCountry.name)")
//        delegate?.didSelectCountry(country: selectedCountry)
//
//        if presentationMethod == .MODAL {
//            self.dismiss(animated: true, completion: nil)
//        } else if presentationMethod == .PUSHED || presentationMethod == .UNKNOWN {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
}
