//
//  SettingsViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/21/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tweetsCountLbl: UILabel!
    @IBOutlet weak var avoidRetweetsSwitch: UISwitch!
    @IBOutlet weak var avoidReplyTweetsSwitch: UISwitch!
    
    // Should come from App Preferences
    var tweetsCount: Int = 20
    var avoidRetweets: Bool = false
    var avoidReplyTweets: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tweetsCountLbl.text = "20"
        avoidRetweetsSwitch.setOn(false, animated: false)
        avoidReplyTweetsSwitch.setOn(false, animated: false)
    }
    
    @IBAction func tweetsCountStepperValueChanged(_ sender: UIStepper) {
        tweetsCount = Int(sender.value)
        self.tweetsCountLbl.text = String(tweetsCount)
    }
    
    @IBAction func avoidRetweetsSwitchValueChanged(_ sender: UISwitch) {
        avoidRetweets = sender.isOn
    }
    
    @IBAction func avoidReplyTweetsValueChanged(_ sender: UISwitch) {
        avoidReplyTweets = sender.isOn
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
    }
    
}
