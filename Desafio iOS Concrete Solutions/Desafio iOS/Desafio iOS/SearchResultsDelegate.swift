//
//  SearchResultsDelegate.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 21/12/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit

class SearchResultsDelegate: NSObject, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("DID BEGIN")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("DID END")
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("SEARCH CLICKED")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("CANCEL CLICKED")
    }

}
