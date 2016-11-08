//
//  PullRequest.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 03/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import UIKit

class PullRequest {
    
    var userAvatar: UIImage?
    var userName: String
    var pullRequestName: String
    var pullRequestBody: String
    var pullRequestLink: String
    
    init(userAvatar: UIImage?, userName: String, pullRequestName: String, pullRequestBody: String, pullRequestLink: String) {
        self.userAvatar = userAvatar
        self.userName = userName
        self.pullRequestName = pullRequestName
        self.pullRequestBody = pullRequestBody
        self.pullRequestLink = pullRequestLink
    }
}
