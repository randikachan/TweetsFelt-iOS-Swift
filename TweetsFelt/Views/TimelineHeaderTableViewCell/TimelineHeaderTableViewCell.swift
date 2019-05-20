//
//  TimelineHeaderTableViewCell.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit
import Alamofire

class TimelineHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImgVw.load(url: URL(string: "https://pbs.twimg.com/profile_images/751077179530747904/13kBfZs5_bigger.jpg")!)
        profileImgVw.layer.cornerRadius = profileImgVw.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
