//
//  RepositoryListDataSource.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryListDataSource: NSObject, UITableViewDataSource {
    
    var repositoryList = [Repository]()
    var filteredRepositories = [Repository]()
    weak var searchController: UISearchController!
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredRepositories.count
        }
        
        return repositoryList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRepoList") as! RepositoryTableViewCell
        
        let repository: Repository
        
        if searchController.isActive && searchController.searchBar.text != "" {
            repository = filteredRepositories[indexPath.row]
        }
        else {
        
            repository = repositoryList[indexPath.row]
        }
        
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
            
            
//            let queue = DispatchQueue(label: "teste")

//            queue.async {
//                if let data = try? Data(contentsOf: url) {
//                    
////                    DispatchQueue.main.async {
////                        cell.userAvatarPhoto.image = UIImage(data: data)
////                    }
//                    
//                }
//            }
            
            

        }
        
        return cell;
    }
}
