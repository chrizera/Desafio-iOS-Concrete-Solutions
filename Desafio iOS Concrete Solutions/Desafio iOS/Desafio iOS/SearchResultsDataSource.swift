//
//  SearchResultsDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 21/12/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class SearchResulsDataSource: NSObject, UITableViewDataSource {
    
    var repositories = [Repository]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRepoList") as! RepositoryTableViewCell
        
        let repository = repositories[indexPath.row]
        
        cell.repositoryNameLabel.text = repository.name
        cell.repositoryDescriptionLabel.text = repository.description
        cell.userNameLabel.text = repository.owner?.username
        
        
        if let stars = repository.stars {
            cell.starsLabel.text = String(stars)
        }
        
        if let forks = repository.forks {
            cell.forksLabel.text = String(forks)
        }
        
        if let url = repository.owner?.avatarUrl {
            cell.userAvatarPhoto.kf.indicatorType = .activity
            cell.userAvatarPhoto.kf.setImage(with: url)
            
        }
        
        return cell;
    }
}
