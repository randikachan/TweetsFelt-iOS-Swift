//
//  ViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit
import Keys

class ViewController: UIViewController {

    let keys = TweetsFeltKeys()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let twitterAPIService = TwitterAPIService.shared
        twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (json, error) in
            print("completed: \(json)")
        }
    }


}

