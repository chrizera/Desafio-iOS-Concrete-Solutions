//
//  RepositoryAFTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 08/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import WebKit

class RepositoryAFTableViewController: UITableViewController {
    
    let repositoryDataSource = RepositoryTableViewDataSource()
    
    let json = JSONParser()
    
    var github: GitHub? {
        didSet {
            guard let github = github else { return }
            self.repositoryName = github.repositoryName
            self.userName = github.userName
        }
    }
    
    var userName = String()
    var repositoryName = String()
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = repositoryName
        
        self.tableView.dataSource = repositoryDataSource
        
        json.parseJSONPullRequestList(dataSource: repositoryDataSource, tableView: tableView, userName: userName, repositoryName: repositoryName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = repositoryDataSource.pullRequestList[indexPath.row].pullRequestLink
        guard let url = URL(string: link) else {return}
        let request = URLRequest(url: url)
        
        let webViewRect = view.frame
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: webViewRect, configuration: configuration)
        webView.load(request)
        
        self.performSegue(withIdentifier: "ShowPullRequest", sender: self)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? PullRequestViewController {
            
            destination.webView = webView
        }
    }
    

}
