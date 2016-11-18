//
//  RepositoryListDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class RepositoryListDataSource: NSObject, UITableViewDataSource {
    
    var repositoryList = [Repository]()
    
    override init() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRepoList") as! RepositoryTableViewCell
        
        let repository = repositoryList[indexPath.row]
        
        cell.repositoryNameLabel.text = repository.repositoryName
        cell.repositoryDescriptionLabel.text = repository.repositoryDescription
        cell.starsLabel.text = String(repository.stars)
        cell.forksLabel.text = String(repository.forks)
        cell.userNameLabel.text = repository.userName
        cell.userAvatarPhoto.image = repository.userAvatar
        
        return cell;
    }
}
