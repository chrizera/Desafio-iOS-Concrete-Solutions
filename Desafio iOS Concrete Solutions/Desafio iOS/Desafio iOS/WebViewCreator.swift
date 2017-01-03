//
//  WebViewCreator.swift
//  Desafio iOS
//
//  Created by Christian Perrone on 21/11/16.
//  Copyright © 2016 Christian Perrone. All rights reserved.
//

import UIKit
import WebKit

class WebViewCreator {
    
    func createWebView(link: URL, view: UIView) -> WKWebView {
        
        let webViewRect = view.frame
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: webViewRect, configuration: configuration)
        let request = URLRequest(url: link)
        webView.load(request)
        
        return webView
        
        }
}
