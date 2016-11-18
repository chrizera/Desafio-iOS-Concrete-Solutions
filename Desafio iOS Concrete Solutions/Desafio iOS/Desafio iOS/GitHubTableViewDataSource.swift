//
//  GitHubTableViewDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 16/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class GitHubTableViewDataSource: NSObject, UITableViewDataSource {
    
    var githubRepoList = [GitHub]()
    //var githubRepoList = [String]()
    
    init(githubRepoList: [GitHub]) {
        self.githubRepoList = githubRepoList
    }
    
    override init() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return githubRepoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRepoList") as! GitHubTableViewCell
        
        let github = githubRepoList[indexPath.row]
        
        cell.repositoryNameLabel.text = github.repositoryName
        cell.repositoryDescriptionLabel.text = github.repositoryDescription
        cell.starsLabel.text = String(github.stars)
        cell.forksLabel.text = String(github.forks)
        cell.userNameLabel.text = github.userName
        cell.userAvatarPhoto.image = github.userAvatar
        
        return cell;
    }
    
}
