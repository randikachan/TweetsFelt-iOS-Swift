//
//  TwitterTimelineViewController.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/20/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import UIKit
import Keys
import ObjectMapper
import Alamofire

class TwitterTimelineViewController: UIViewController {
    
    let keys = TweetsFeltKeys()
    
    // Mark - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var statusLbl: UILabel!
    
    // Mark - ViewModel injection
    let viewModel = TwitterTimelineVCViewModel()
    
    var searchResultTweetsArr: [Tweet] = [] {
        didSet {
            if (self.searchResultTweetsArr.count > 0) {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            } else {
                self.tableView.isHidden = true
            }
        }
    }
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the TableViewCell Nib files
        let tableViewCellNib: UINib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "tweetCell")
        
        let tableViewHeaderCellNib: UINib = UINib(nibName: "TimelineHeaderTableViewCell", bundle: nil)
        self.tableView.register(tableViewHeaderCellNib, forCellReuseIdentifier: "timelineHeaderCell")
        
        // Setup initial Search View UI state
        self.searchResultTweetsArr = viewModel.searchResultTweetsArr ?? []
        
        viewModel.initializeAPIToken {
            self.activityIndicator.isHidden = !self.viewModel.isLoading
            self.statusLbl.text = self.viewModel.statusLblText
        }
    }
}
