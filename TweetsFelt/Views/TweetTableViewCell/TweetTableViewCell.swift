//
//  TweetTableViewCell.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell, TweetTableViewCellDelegate {

    // To identify the cell and update the content accordingly
    var delegate: TweetTableViewCellDelegate?
    
    var tweet: Tweet?
    
    @IBOutlet weak var sentimentThumbLbl: UILabel!
    @IBOutlet weak var tweetTextLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentCoverBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        containerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.7066299229)
        containerView.layer.cornerRadius = 15
        
        contentView.backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func analyzeSentimentCellButtonTapped(_ sender: UIButton) {
        // call delegate
        delegate?.analyzeDocumentSentimentAndUpdate(self, completion: { (documentSentiment) in
            if self.tweet == nil { return }
            self.tweet!.sentiment = documentSentiment
            self.sentimentThumbLbl.text = self.tweet!.sentiment?.getMood()
        })
    }
    
    // Customize and update the cell with data
    func configureCellFor(tweet: Tweet, tag: Int) {
        self.tweet = tweet
        self.sentimentThumbLbl.backgroundColor = UIColor.clear
        self.tweetTextLbl.backgroundColor = UIColor.clear
        self.tweetTextLbl.text = tweet.text
        self.sentimentThumbLbl.text = tweet.sentiment?.getMood()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7458261986)
        self.clipsToBounds = true
        self.delegate = self

        self.tag = tag
    }

}
