//
//  PullRequest.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 03/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequest: Mappable {
    
    var name: String?
    var body: String?
    var link: URL?
    var user: PullRequestUser?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name <- map["title"]
        body <- map["body"]
        link <- (map["html_url"], URLTransform())
        user <- map["user"]
    }
}
