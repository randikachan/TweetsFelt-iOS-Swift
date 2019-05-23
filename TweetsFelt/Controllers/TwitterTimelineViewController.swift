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
            self.tableView.reloadData()
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
        activityIndicator.isHidden = false
        tableView.isHidden = true
        self.statusLbl.text = "Search for a Twitter Screen Name to View and Feel its Timeline!"
        
        initializeAPIToken_delete_later()
    }
}

// MARK: - UITableView DataSource

extension TwitterTimelineViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultTweetsArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.configureCellFor(tweet: self.searchResultTweetsArr[indexPath.item], tag: indexPath.item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // This will turn on `masksToBounds` before the cell is displayed
        cell.contentView.layer.masksToBounds = true
        
        // for smooth scrolling
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
}

// MARK: - UITableView Delegate
extension TwitterTimelineViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK - Network Service Calls

extension TwitterTimelineViewController {

    func initializeAPIToken_delete_later() {
    }
    
    func fetchTwitterTimelineFor_delete_later(screenName: String) {
    }

}
