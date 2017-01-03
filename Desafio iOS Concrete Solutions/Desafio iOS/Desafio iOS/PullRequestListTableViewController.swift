//
//  PullRequestListTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import Foundation
import WebKit
import Kingfisher

class PullRequestListTableViewController: UITableViewController {

    let pullRequestDataSource = PullRequestListDataSource()
    let pullRequestDelegate = PullRequestListDelegate()
    let json = JSONParser()
    
    var repository: Repository? {
        didSet {
            guard let repository = repository else { return }
            self.repositoryName = repository.name
            self.userName = repository.owner?.username
        }
    }
    var userName: String?
    var repositoryName:  String?
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.updateConstraints()
        
        navigationItem.title = repositoryName

        self.pullRequestDelegate.viewController = self
        
        self.tableView.dataSource = pullRequestDataSource
        self.tableView.delegate = pullRequestDelegate
        
        json.parseJSONPullRequestList(dataSource: pullRequestDataSource, tableView: tableView, userName: userName, repositoryName: repositoryName)
        
    }
    
    //******************************************************************APAGAR
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
        
        if let destination = segue.destination as? PullRequestViewController{
            
            destination.webView = webView            
        }
    }
}
