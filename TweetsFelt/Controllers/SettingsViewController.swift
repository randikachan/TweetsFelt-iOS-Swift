//
//  SettingsViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var avoidRetweetsSwitch: UISwitch!
    @IBOutlet weak var avoidReplyTweets: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func avoidRetweetsSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func avoidReplyTweetsValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
    }
    
}
