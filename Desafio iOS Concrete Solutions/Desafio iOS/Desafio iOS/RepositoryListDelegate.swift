//
//  RepositoryListDelegate.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 18/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class RepositoryListDelegate: NSObject, UITableViewDelegate {
    
    weak var viewController:RepositoryListTableViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        viewController?.performSegue(withIdentifier: "ShowPullRequestList", sender: nil)

    }
}
