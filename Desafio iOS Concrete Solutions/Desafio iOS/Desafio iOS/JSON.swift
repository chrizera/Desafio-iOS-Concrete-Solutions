//
//  JSON.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 31/10/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation

class JSON {
    
    let link = "https://api.github.com/search/repositories?q=language:java&sort=stars"
    guard let url = URL(string: link) else {return}
}
