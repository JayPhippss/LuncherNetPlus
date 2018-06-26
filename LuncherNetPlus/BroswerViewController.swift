//
//  BroswerViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/18/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import WebKit


class BroswerViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBrn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var twitterUrl = ""
    var citiUrl = "https://www.citi.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.progressView.progress = 0
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUrlCall()
    }
    

    @IBAction func backBtnClick(_ sender: Any) {
        //if it can go back then go back
        if(webView.canGoBack){
            //forwardBtn.isEnabled = true
            webView.goBack()
        }
    }
    
    @IBAction func refreshBtnClick(_ sender: Any) {
        //simply reload the page
        webView.reload()
    }
    
    @IBAction func forwardBtnClick(_ sender: Any) {
        //if it can go forward the go forward
        if(webView.canGoForward){
            webView.goForward()
        }
    }
    
    func getTwitter() {
        let urlText = "https://www.twitter.com/"
        let fullUrl = (urlText + (twitterUrl))
        let url: URL = URL(string: fullUrl)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
   func getUrlCall() {
//        let urlText = "https://www.citi.com"
        let url: URL = URL(string: citiUrl)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        backBrn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
}
