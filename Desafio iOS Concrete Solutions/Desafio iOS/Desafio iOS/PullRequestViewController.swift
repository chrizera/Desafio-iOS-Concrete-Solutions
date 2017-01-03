//
//  PullRequestViewController.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 04/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import WebKit

class PullRequestViewController: UIViewController {
    
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
