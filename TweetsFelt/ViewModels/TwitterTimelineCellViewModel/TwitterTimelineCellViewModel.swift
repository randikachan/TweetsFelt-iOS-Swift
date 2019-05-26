//
//  TwitterTimelineCellViewModel.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation

class TwitterTimelineCellViewModel {
    
    private var sentimentThumbLblText: String?
    private var tweetTextLblText: String?
    
    public init(sentimentEmoji: String, tweetText: String) {
        self.sentimentThumbLblText = sentimentEmoji
        self.tweetTextLblText = tweetText
    }
    
    public init(with tweet: Tweet, tableViewIndex: Int) {
        if let sentiment = tweet.sentiment,
            let tweetText = tweet.text {
            self.sentimentThumbLblText = sentiment.getMood()
            self.tweetTextLblText = tweetText
        }
    }
}

extension TwitterTimelineCellViewModel: TweetTableViewCellDelegate {
    
    func analyzeDocumentSentimentAndUpdate(_ cell: TweetTableViewCell, completion: @escaping (GoogleNLDocumentSentiment) -> Void) {
        if let tweetTextContent = cell.tweetTextLbl.text {
            // Activity Indicator
            cell.activityIndicator.isHidden = false
            
            // Prepare the document and the API call
            let googleAPIService = GoogleNaturalLangAPIService.shared
            let documentRequest = googleAPIService.generateDocumentRequestData(content: tweetTextContent)
            
            googleAPIService.analyzeDocument(document: documentRequest) { (googleSentimentObj, googleSentimentArr, baseError) in
                // Hide the activity Indicator
                
                cell.activityIndicator.isHidden = true
                if let googleSentiment = googleSentimentObj,
                    let documentSentiment = googleSentiment.documentSentiment {
                    completion(documentSentiment)
                    cell.sentimentThumbLbl.text = googleSentimentObj?.documentSentiment?.getMood()
                } else if baseError != nil {
                    cell.sentimentThumbLbl.text = "⁉️"
                }
            }
        }
    }
}
