//
//  Teste.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 26/10/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class Teste: UITableViewController {
    
    let searchURL = "https://api.github.com/search/repositories?q=language:java&sort=stars"
//    let json = JSONSerialization.
    
    var dict: Dictionary<String, Any>? {
        didSet {
            guard let dict = dict else { return }
            guard let items = dict["items"] as? Array<Any> else { return }
            print ("\(items.count)")
            print("\(items[20])")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: searchURL) else { return }
        
        let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) in
            self.handleReturn(data: data, response: response, error: error)
        }
        
        let dataDatask = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        dataDatask.resume()
    }
    
    func handleReturn(data: Data?, response: URLResponse?, error: Error?) -> Void {
        guard let data = data else { return }
        if let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any> {
            self.dict = dict
        }
    }
}
