//
//  NetworkProtocol.swift
//  TweetsFelt
//
//  Created by Randika Vishman on 5/19/19.
//  Copyright © 2019 randika. All rights reserved.
//

import Foundation
import ObjectMapper

protocol NetworkProtocol {
    
    func execute<Type>(_ endpoint: Endpoint, completion: @escaping (Type?, [Type]?, TwitterErrorResponse?) -> Void) where Type: BaseMappable

}
