//
//  PullRequestListDelegate.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 21/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import WebKit

class PullRequestListDelegate: NSObject, UITableViewDelegate {
    
    weak var viewController: PullRequestListTableViewController?
    let creator = WebViewCreator()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewController = viewController else { return }
        guard let link = viewController.pullRequestDataSource.pullRequestList[indexPath.row].link else { return }
        
        viewController.webView = creator.createWebView(link: link, view: viewController.view)
        viewController.performSegue(withIdentifier: "ShowPullRequest", sender: nil)
    }
}
