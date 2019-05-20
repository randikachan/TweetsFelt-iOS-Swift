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
        
        Helper.setTableViewBackgroundGradient(view: self.view, tableView: self.tableView, #colorLiteral(red: 0.002226956359, green: 0.8108235771, blue: 1, alpha: 1), #colorLiteral(red: 0.03017414983, green: 0.5037739766, blue: 1, alpha: 1))
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        // At this point, the didSet block will set up the cell's views
        cell.sentimentThumbLbl.text = sentimentEmojisArr[0]
        cell.sentimentThumbLbl.backgroundColor = UIColor.clear
        
        cell.tweetTextTVw.backgroundColor = UIColor.clear
        cell.tweetTextTVw.text = self.tweetsArr[indexPath.item].text
        cell.tweetTextTVw.isEditable = false
        cell.tweetTextTVw.isSelectable = false
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7458261986)
        
        return cell;
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please search for screen name to view Tweets"
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
