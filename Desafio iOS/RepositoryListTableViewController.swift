//
//  RepositoryListTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class RepositoryListTableViewController: UITableViewController {

    let repositoryListDataSource = RepositoryListDataSource()
    let repositoryListDelegate = RepositoryListDelegate()
    let json = JSONParser()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.repositoryListDelegate.viewController = self
        
        self.tableView.dataSource = repositoryListDataSource
        self.tableView.delegate = repositoryListDelegate
        
        json.parseJSONRepositoryList(dataSource: repositoryListDataSource, tableView: tableView)
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
        
        if let destination = segue.destination as? PullRequestListTableViewController, let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            
            destination.repository = repositoryListDataSource.repositoryList[selectedIndexPath.row]
        }
    }
}
