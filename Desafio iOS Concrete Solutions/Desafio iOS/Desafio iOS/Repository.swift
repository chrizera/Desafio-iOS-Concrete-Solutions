//
//  Repository.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable {
    
    var name: String?
    var description: String?
    var owner: RepositoryOwner?
    var forks: Int?
    var stars: Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        owner <- map["owner"]
        forks <- map["forks"]
        stars <- map["stargazers_count"]
    }
    
   
}
