//
//  Downloader.swift
//  PDF Web View
//
//  Created by Kishore on 12/09/18.
//  Copyright © 2018 Mindtree. All rights reserved.
//

import Foundation

class Downloader {
    class func load(URL: URL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL as URL)
        request.httpMethod = "GET"
        
        guard let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let destinationFileUrl = documentsUrl.appendingPathComponent(URL.lastPathComponent)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))");
            }
        }
        task.resume()
    }
}
