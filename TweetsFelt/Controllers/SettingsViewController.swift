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
    @IBOutlet weak var tweetsCountStepper: UIStepper!
    
    // Should come from App Preferences
    var tweetsCount: Int = 20
    var avoidRetweets: Bool = false
    var avoidReplyTweets: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tCount = AppPreferenceService.shared.getFetchTweetsCount()
        self.tweetsCountLbl.text = String((tCount == 0) ? 20 : tCount)
        self.tweetsCountStepper.value = Double((tCount == 0) ? 20 : tCount)
        
        self.avoidRetweetsSwitch.setOn(!AppPreferenceService.shared.avoidReTweets(), animated: false)
        
        self.avoidReplyTweetsSwitch.setOn(!AppPreferenceService.shared.avoidReplyTweets(), animated: false)
    }
    
    @IBAction func tweetsCountStepperValueChanged(_ sender: UIStepper) {
        self.tweetsCountLbl.text = String(Int(sender.value))
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        AppPreferenceService.shared.saveFetchTweetsCount(count: Int(self.tweetsCountStepper.value))
        AppPreferenceService.shared.saveAvoidReTweets(avoidReTweets: !self.avoidRetweetsSwitch.isOn)
        AppPreferenceService.shared.saveAvoidReplyTweets(avoidReplyTweets: !self.avoidReplyTweetsSwitch.isOn)
    }
    
}
