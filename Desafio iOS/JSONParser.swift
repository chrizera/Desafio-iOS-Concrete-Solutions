//
//  JSONParser.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 17/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JSONParser {
    
      func parseJSONRepositoryList(dataSource: RepositoryListDataSource, tableView: UITableView) {

        let link = "https://api.github.com/search/repositories?q=language:java&sort=stars"
        guard let url = URL(string: link) else {return}
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            let json = JSON(response.result.value)
            let githubDictionary = json["items"].array!
            
            for items in githubDictionary {
                
                let repository = Repository(repositoryName: "", repositoryDescription: "", userAvatar: nil, userName: "", forks: 0, stars: 0)
                
                let img = items["owner"]["avatar_url"].string!
                guard let url = URL(string: img) else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                
                repository.userAvatar = UIImage(data: data)
                repository.repositoryName = items["name"].string!
                repository.repositoryDescription = items["description"].string!
                repository.forks = items["forks"].int!
                repository.stars = items["stargazers_count"].int!
                repository.userName = items["owner"]["login"].string!
                
                dataSource.repositoryList.append(repository)
            }
            
            tableView.reloadData()
            
        }
    }
    
    func parseJSONPullRequestList(dataSource: PullRequestListDataSource, tableView: UITableView, userName: String, repositoryName: String) {

    
        let link = "https://api.github.com/repos/\(userName)/\(repositoryName)/pulls"
        guard let url = URL(string: link) else {return}
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            let json = JSON(response.result.value)
            
            let pullRequestJSONArray = json.array!
            
            for items in pullRequestJSONArray {
                
                let pullRequest = PullRequest(userAvatar: nil, userName: "", pullRequestName: "", pullRequestBody: "", pullRequestLink: "")
                
                let img = items["user"]["avatar_url"].string!
                guard let url = URL(string: img) else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                
                pullRequest.userAvatar = UIImage(data: data)
                pullRequest.pullRequestBody = items["body"].string!
                pullRequest.pullRequestName = items["title"].string!
                pullRequest.pullRequestLink = items["html_url"].string!
                pullRequest.userName = items["user"]["login"].string!
                
                dataSource.pullRequestList.append(pullRequest)
                
            }
            tableView.reloadData()
        }
    }
}
