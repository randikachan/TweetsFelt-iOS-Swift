//
//  TweetTableViewCellDelegate.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/24/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

protocol TweetTableViewCellDelegate {

    func analyzeDocumentSentimentAndUpdate(_ cell: TweetTableViewCell, completion: @escaping (GoogleNLDocumentSentiment) -> Void)
}

