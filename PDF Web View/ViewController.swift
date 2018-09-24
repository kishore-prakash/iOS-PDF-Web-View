//
//  ViewController.swift
//  PDF Web View
//
//  Created by Kishore on 11/09/18.
//  Copyright © 2018 Mindtree. All rights reserved.
//

import UIKit
import WebKit
//import PDFReader

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"http://www.pdfpdf.com/samples.html")
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = self
        webView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBT(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func reloadBT(_ sender: UIBarButtonItem) {
        let myURL = URL(string:"http://www.pdfpdf.com/samples.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)

        if navigationAction.navigationType == WKNavigationType.linkActivated {
            guard let fileURL = navigationAction.request.url else {
                print("Unable to get url")
                return
            }
            let fileExtension = fileURL.pathExtension
            if fileExtension.lowercased() == "pdf" {
                print("This is a PDF link")

                Downloader.load(URL: fileURL)
//                webView.load(navigationAction.request)

            }
        }

    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("navigationResponse")
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
}

