//
//  TwitterTimelineNetworkProtocol.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/23/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

protocol TwitterTimelineNetworkProtocol {
    
    func onErrorShowAlert(error: BaseAPIError)
    func updateLoadingStatus()
    func didFinishGetBearerToken()
    func didFinishFetchTwitterTimelin(tweetsArr: [Tweet])

}
