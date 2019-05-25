//
//  TwitterTimeline+TableViewDelegate.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/25/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import UIKit

extension TwitterTimelineViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

