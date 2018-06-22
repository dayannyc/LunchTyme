//
//  InternetViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/12/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit
import WebKit

class InternetViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"http://www.citi.com")
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
        webView?.navigationDelegate = self
    }
    
    @IBAction func webBackBttn(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func webRefreshBttn(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func webForwardBttn(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
