//
//  GitHub.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 31/10/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import UIKit

class GitHub {
    
    var repositoryName: String
    var repositoryDescription: String
    var userAvatar: UIImage?
    var userName: String
    var forks: Int
    var stars: Int
    
    init(repositoryName: String, repositoryDescription: String, userAvatar: UIImage?, userName: String, forks: Int, stars: Int) {
        self.repositoryName = repositoryName
        self.repositoryDescription = repositoryDescription
        self.userAvatar = userAvatar
        self.userName = userName
        self.forks = forks
        self.stars = stars
    }
}
