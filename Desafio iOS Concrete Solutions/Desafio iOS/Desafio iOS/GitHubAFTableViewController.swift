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
    
    
    let githubDataSource = GitHubTableViewDataSource()
    let githubDelegate = GitHubTableViewDelegate()
    let json = JSONParser()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.githubDelegate.viewController = self
        
        self.tableView.dataSource = githubDataSource
        self.tableView.delegate = githubDelegate
        
        json.parseJSONRepositoryList(dataSource: githubDataSource, tableView: tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? RepositoryAFTableViewController, let selectedIndexPath = self.tableView.indexPathForSelectedRow {

            destination.github = githubDataSource.githubRepoList[selectedIndexPath.row]
        }
    }
    
}
