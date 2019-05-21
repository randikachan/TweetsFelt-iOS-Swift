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
        self.tweetsCount = AppPreferenceService.shared.getFetchTweetsCount() ?? 20
        self.tweetsCountLbl.text = String(tweetsCount)
        self.tweetsCountStepper.value = Double(self.tweetsCount)
        
        self.avoidRetweetsSwitch.setOn(AppPreferenceService.shared.getAvoidReTweets() ?? false, animated: false)
        self.avoidRetweets = AppPreferenceService.shared.getAvoidReTweets() ?? false
        
        self.avoidReplyTweetsSwitch.setOn(AppPreferenceService.shared.getAvoidReplyTweets() ?? false, animated: false)
        self.avoidReplyTweets = AppPreferenceService.shared.getAvoidReplyTweets() ?? false
    }
    
    @IBAction func tweetsCountStepperValueChanged(_ sender: UIStepper) {
        self.tweetsCount = Int(sender.value)
        self.tweetsCountLbl.text = String(tweetsCount)
    }
    
    @IBAction func avoidRetweetsSwitchValueChanged(_ sender: UISwitch) {
        self.avoidRetweets = sender.isOn
    }
    
    @IBAction func avoidReplyTweetsValueChanged(_ sender: UISwitch) {
        self.avoidReplyTweets = sender.isOn
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        AppPreferenceService.shared.saveFetchTweetsCount(count: self.tweetsCount)
        AppPreferenceService.shared.saveAvoidReTweets(avoidReTweets: self.avoidRetweets)
        AppPreferenceService.shared.saveAvoidReplyTweets(avoidReplyTweets: self.avoidReplyTweets)
    }
    
}
