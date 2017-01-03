//
//  JSONParser.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 17/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class JSONParser {
    
      func parseJSONRepositoryList(dataSource: RepositoryListDataSource, tableView: UITableView) {

        let link = "https://api.github.com/search/repositories?q=language:java&sort=stars"
        guard let url = URL(string: link) else { return }
        
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            let repository = Mapper<RepositoryItems>().map(JSON: response.result.value as! [String:Any])
            guard let items = repository?.items else { return }
            
            dataSource.repositoryList.append(contentsOf:items)
            tableView.reloadData()
            
        }
    }
    
    func parseJSONPullRequestList(dataSource: PullRequestListDataSource, tableView: UITableView, userName: String?, repositoryName: String?) {

        guard let userName = userName else { return }
        guard let repositoryName = repositoryName else { return }
        
        let link = "https://api.github.com/repos/\(userName)/\(repositoryName)/pulls"
        guard let url = URL(string: link) else { return }
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            guard let pullRequestList = Mapper<PullRequest>().mapArray(JSONArray: response.result.value as! [[String:Any]]) else { return }
    
            dataSource.pullRequestList.append(contentsOf: pullRequestList)
            
            tableView.reloadData()
        }
    }
}
