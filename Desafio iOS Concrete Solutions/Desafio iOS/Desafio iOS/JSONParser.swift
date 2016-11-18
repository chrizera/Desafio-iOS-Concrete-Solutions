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
    
    func parseJSONRepositoryList(dataSource: GitHubTableViewDataSource, tableView: UITableView) {
        
        let link = "https://api.github.com/search/repositories?q=language:java&sort=stars"
        guard let url = URL(string: link) else {return}
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            let json = JSON(response.result.value)
            let githubDictionary = json["items"].array!
            
            for items in githubDictionary {
                
                let github = GitHub(repositoryName: "", repositoryDescription: "", userAvatar: nil, userName: "", forks: 0, stars: 0)
                
                let img = items["owner"]["avatar_url"].string!
                guard let url = URL(string: img) else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                
                github.userAvatar = UIImage(data: data)
                github.repositoryName = items["name"].string!
                github.repositoryDescription = items["description"].string!
                github.forks = items["forks"].int!
                github.stars = items["stargazers_count"].int!
                github.userName = items["owner"]["login"].string!
                
                dataSource.githubRepoList.append(github)
            }
            
            tableView.reloadData()
            
        }
    }
    
    func parseJSONPullRequestList(dataSource: RepositoryTableViewDataSource, tableView: UITableView, userName: String, repositoryName: String) {
        
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
