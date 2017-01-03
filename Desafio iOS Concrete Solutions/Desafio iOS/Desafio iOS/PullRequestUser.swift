//
//  PullRequestUser.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 07/12/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequestUser: Mappable{
    
    var avatarUrl: URL?
    var username: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        avatarUrl <- (map["avatar_url"], URLTransform())
        username <- map["login"]
    }
    
}
