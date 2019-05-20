//
//  TimelineHeaderTableViewCell.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import UIKit

class TimelineHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
