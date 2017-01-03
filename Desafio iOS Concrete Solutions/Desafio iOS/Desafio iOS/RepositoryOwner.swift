//
//  RepositoryOwner.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 06/12/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import ObjectMapper

class RepositoryOwner: Mappable {
    
    var username: String?
    var avatarUrl: URL?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        username <- map["login"]
        avatarUrl <- (map["avatar_url"], URLTransform())
    }
}
