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
//        twitterAPIService.getBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret) { (json, error) in
//            print("completed: \(json)")
//        }
        
//        twitterAPIService.invalidateBearerToken(api_key: keys.twitterConsumerAPIKey, api_secret: keys.twitterConsumerAPISecret, bearerToken: "AAAAAAAAAAAAAAAAAAAAANgB%2BgAAAAAA%2FGFWqt%2Fha2t1%2BfwJAgoLxTEEGBQ%3DLK59a8a7Qqm89mSeIHw1UJh0GivM7BYBJdfi0gSJNsDl40H9Vs") { (json, jsonError) in
//
//            print("completed 1: \(jsonError?.error?.localizedDescription)")
//
//            if let jsonErrorResponse = jsonError,
//                let error = jsonErrorResponse.errors?[0] {
//                print("completed 2: \(error.message)")
//            }
//
//        }
        
        twitterAPIService.fetchUserTimelineFor(screen_name: "randikachan", bearerToken: "AAAAAAAAAAAAAAAAAAAAANgB%2BgAAAAAA%2FGFWqt%2Fha2t1%2BfwJAgoLxTEEGBQ%3DLK59a8a7Qqm89mSeIHw1UJh0GivM7BYBJdfi0gSJNsDl40H9Vs") { (json, jsonError) in

            print("completed 1: \(jsonError?.error?.localizedDescription)")
            
            if let jsonErrorResponse = jsonError,
                let error = jsonErrorResponse.errors?[0] {
                print("completed 2: \(error.message)")
            }

        }
    }


}

