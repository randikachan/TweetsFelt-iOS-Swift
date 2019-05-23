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

extension TweetTableViewCellDelegate {
    
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

