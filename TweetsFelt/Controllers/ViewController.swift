//
//  ViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit
import Keys
import ObjectMapper

class ViewController: UIViewController {

    let keys = TweetsFeltKeys()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        activityIndicator.isHidden = false
        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (tokenObject, tokenArr, jsonError) in
            print("completed: \(String(describing: tokenObject?.toJSONString()))")
            self.activityIndicator.isHidden = true
        }
    }

}

