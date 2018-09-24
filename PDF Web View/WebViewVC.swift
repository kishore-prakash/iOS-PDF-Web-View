//
//  WebViewVC.swift
//  PDF Web View
//
//  Created by Kishore on 12/09/18.
//  Copyright © 2018 Mindtree. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urlToLoad = urlToLoad, let fileURL = URL(string: urlToLoad) {
            webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
        }
    }
    
    @IBAction func printBT(_ sender: UIBarButtonItem) {
        if let urlToLoad = urlToLoad, let fileURL = URL(string: urlToLoad) {
            if UIPrintInteractionController.canPrint(fileURL) {
                let printInfo = UIPrintInfo(dictionary: nil)
                printInfo.jobName = fileURL.lastPathComponent
                printInfo.outputType = .general
                
                let printController = UIPrintInteractionController.shared
                printController.printInfo = printInfo
                printController.showsNumberOfCopies = false
                
                printController.printingItem = fileURL
                
                printController.present(animated: true, completionHandler: nil)
            }
        }
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
