//
//  TweetTableViewCell.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit
protocol AnalyzeTweetContentCellDelegate {
    func analyzeDocumentSentimentAndUpdate(_ cell: TweetTableViewCell)
}

class TweetTableViewCell: UITableViewCell {

    // To identify the cell and update the content accordingly
    var delegate: AnalyzeTweetContentCellDelegate?
    
    @IBOutlet weak var sentimentThumbLbl: UILabel!
    @IBOutlet weak var tweetTextLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentCoverBtn: UIButton!
    
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
        delegate?.analyzeDocumentSentimentAndUpdate(self)
    }
}
