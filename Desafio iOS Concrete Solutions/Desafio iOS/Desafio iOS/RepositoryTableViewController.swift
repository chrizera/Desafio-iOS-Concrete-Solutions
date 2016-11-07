//
//  RepositoryTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 01/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import WebKit

class RepositoryTableViewController: UITableViewController {
    
    var userName = String()
    var repositoryName = String()
    var userAvatar = UIImage()
    var pullRequestList = [PullRequest]()
    var pullRequestLink = String()
    var pullRequestWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = repositoryName

        let link = "https://api.github.com/repos/\(userName)/\(repositoryName)/pulls"
        //print(link)
        guard let url = URL(string: link) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]{
            
            for items in json {
                
                let pullRequest = PullRequest(repositoryName: "", userAvatar: nil, userName: "", pullRequestName: "", pullRequestBody: "", pullRequestLink: "")
                let dict = items["user"] as! [String:Any]
                
                pullRequest.pullRequestName = items["title"] as! String
                pullRequest.pullRequestBody = items["body"] as! String
                pullRequest.pullRequestLink = items["html_url"] as! String
                
                pullRequest.userName = dict["login"] as! String
                
                let imageLink = dict["avatar_url"] as! String
                guard let imageURL = URL(string: imageLink) else {return}
                guard let data = try? Data(contentsOf: imageURL) else {return}
                let userAvatar = UIImage(data: data)
                
                pullRequest.userAvatar = userAvatar
                
                
                pullRequestList.append(pullRequest)
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return pullRequestList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pullRequestLink = pullRequestList[indexPath.row].pullRequestLink
        
        guard let url = URL(string: pullRequestLink) else {return}
        let request = URLRequest(url: url)
        
        let rect = view.frame
        
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: rect, configuration: webConfiguration)
        webView.load(request)
        
        pullRequestWebView = webView
        
        self.performSegue(withIdentifier: "ShowPullRequest", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPullRequestList", for: indexPath) as! RepositoryTableViewCell

        // Configure the cell...
        
        let pullRequest = pullRequestList[indexPath.row]
        
        cell.pullRequestTitle.text = pullRequest.pullRequestName
        cell.pullRequestDescription.text = pullRequest.pullRequestBody
        cell.userName.text = pullRequest.userName
        cell.userAvatar.image = pullRequest.userAvatar

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
            
            destination.webView = pullRequestWebView
        }
    }
    

}
