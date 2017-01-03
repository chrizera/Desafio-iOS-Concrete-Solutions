//
//  RepositoryListTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryListTableViewController: UITableViewController, UISearchResultsUpdating {

    let repositoryListDataSource = RepositoryListDataSource()
    let repositoryListDelegate = RepositoryListDelegate()
    let json = JSONParser()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    let del = SearchResultsDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.delegate = del
        
        repositoryListDataSource.searchController = searchController
    
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationItem.title = "Github"
        
        self.repositoryListDelegate.viewController = self
        
        self.tableView.dataSource = repositoryListDataSource
        self.tableView.delegate = repositoryListDelegate
        
        json.parseJSONRepositoryList(dataSource: repositoryListDataSource, tableView: tableView)
    
    }
    
    func filterContents(for searchText: String, scope: String = "All") {
        repositoryListDataSource.filteredRepositories = repositoryListDataSource.repositoryList.filter { repository in
            if let name = repository.name {
                return name.lowercased().contains(searchText.lowercased())
            }
            return false
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContents(for: text)
            tableView.reloadData()
        }
    }
    
    
    //**************************APAGAR***********************************************
    override func viewDidDisappear(_ animated: Bool) {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
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
            
            if searchController.isActive && searchController.searchBar.text != "" {
                destination.repository = repositoryListDataSource.filteredRepositories[selectedIndexPath.row]
            
            }
            else {
                destination.repository = repositoryListDataSource.repositoryList[selectedIndexPath.row]

            }
        }
    }
}
