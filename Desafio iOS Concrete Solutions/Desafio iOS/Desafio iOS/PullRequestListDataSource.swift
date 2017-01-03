//
//  PullRequestListDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import Kingfisher

class PullRequestListDataSource: NSObject, UITableViewDataSource {
    
    var pullRequestList = [PullRequest]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPullRequestList") as! PullRequestTableViewCell
        
        let pullRequest = pullRequestList[indexPath.row]
        
        cell.pullRequestTitle.text = pullRequest.name
        cell.pullRequestDescription.text = pullRequest.body
        cell.userName.text = pullRequest.user?.username
        
        if let url = pullRequest.user?.avatarUrl {
            cell.userAvatar.kf.indicatorType = .activity
            cell.userAvatar.kf.setImage(with: url)
        }
        
        return cell
    }
}
