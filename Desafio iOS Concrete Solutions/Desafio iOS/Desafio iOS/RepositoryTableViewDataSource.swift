//
//  RepositoryTableViewDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class RepositoryTableViewDataSource : NSObject, UITableViewDataSource {
    
    var pullRequestList = [PullRequest]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPullRequestList") as! RepositoryTableViewCell
        
        let pullRequest = pullRequestList[indexPath.row]
        
        cell.pullRequestTitle.text = pullRequest.pullRequestName
        cell.pullRequestDescription.text = pullRequest.pullRequestBody
        cell.userAvatar.image = pullRequest.userAvatar
        cell.userName.text = pullRequest.userName
        
        return cell
    }
}
