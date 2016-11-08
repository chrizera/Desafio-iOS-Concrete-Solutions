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
    
    var userName = String()
    var repositoryName = String()
    var pullRequestList = [PullRequest]()
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = repositoryName
        
        parseJSON()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func parseJSON() {
        
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
                                
                self.pullRequestList.append(pullRequest)
                self.tableView.reloadData()

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pullRequestList.count
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = pullRequestList[indexPath.row].pullRequestLink
        guard let url = URL(string: link) else {return}
        let request = URLRequest(url: url)
        
        let webViewRect = view.frame
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: webViewRect, configuration: configuration)
        webView.load(request)
        
        self.performSegue(withIdentifier: "ShowPullRequest", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPullRequestList", for: indexPath) as! RepositoryTableViewCell

        // Configure the cell...
        let pullRequest = pullRequestList[indexPath.row]
        
        cell.pullRequestTitle.text = pullRequest.pullRequestName
        cell.pullRequestDescription.text = pullRequest.pullRequestBody
        cell.userAvatar.image = pullRequest.userAvatar
        cell.userName.text = pullRequest.userName
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
