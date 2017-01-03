//
//  RepositoryItems.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 05/12/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import ObjectMapper

class RepositoryItems: Mappable {
    
    var items : [Repository]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}
