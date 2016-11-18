//
//  GitHubAFTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 08/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class GitHubAFTableViewController: UITableViewController {
    
    
    let dataSource = GitHubTableViewDataSource()
    let json = JSONParser()

    var userName = String()
    var repositoryName = String()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        
        json.parseJSONRepositoryList(dataSource: dataSource, tableView: tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        repositoryName = self.dataSource.githubRepoList[indexPath.row].repositoryName
        userName = self.dataSource.githubRepoList[indexPath.row].userName
        
        self.performSegue(withIdentifier: "ShowPullRequestList", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? RepositoryAFTableViewController {
            
            destination.repositoryName = repositoryName
            destination.userName = userName
        }
    }
    

}
