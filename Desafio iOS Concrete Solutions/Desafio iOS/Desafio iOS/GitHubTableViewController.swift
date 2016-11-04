//
//  GitHubTableViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 31/10/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class GitHubTableViewController: UITableViewController {
    
    var githubRepoList = [GitHub]()
    var githubDictionary: Dictionary<String, Any>?
    var aux = [[String:Any]]()
    
    var userName = String()
    var repositoryName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = "https://api.github.com/search/repositories?q=language:java&sort=stars"
        guard let url = URL(string: link) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any] {
            
            //print(json["items"])
            aux = json["items"] as! [[String : Any]]
            //print(aux[0])
            
            for items in aux {
                
                let github = GitHub(repositoryName: "", repositoryDescription: "", userAvatar: nil, userName: "", forks: 0, stars: 0)
                let dicAux = items["owner"] as! [String:Any]
                
                guard let url = URL(string: dicAux["avatar_url"] as! String) else {return}
                guard let dataImg = try? Data(contentsOf: url) else {return}
                
                github.repositoryName = items["name"] as! String
                github.repositoryDescription = items["description"] as! String
                github.userName = dicAux["login"] as! String
                github.userAvatar = UIImage(data: dataImg)
                github.forks = items["forks"] as! Int
                github.stars = items["stargazers_count"] as! Int
                
                githubRepoList.append(github)
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
        return githubRepoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowRepoList", for: indexPath) as! GitHubTableViewCell

        // Configure the cell...
        
        let github = githubRepoList[indexPath.row]
        
        cell.repositoryNameLabel.text = github.repositoryName
        cell.repositoryDescriptionLabel.text = github.repositoryDescription
        cell.userAvatarPhoto.image = github.userAvatar
        cell.userNameLabel.text = github.userName
        cell.forksLabel.text = String(github.forks)
        cell.starsLabel.text = String(github.stars)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        repositoryName = githubRepoList[indexPath.row].repositoryName
        userName = githubRepoList[indexPath.row].userName
        
        self.performSegue(withIdentifier: "ShowPullRequestList", sender: self)
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
        
        if segue.identifier == "ShowPullRequestList" {
            
            if let destination = segue.destination as? RepositoryTableViewController {
                
                destination.userName = userName
                destination.repositoryName = repositoryName
            }
        }
    }
 
}
