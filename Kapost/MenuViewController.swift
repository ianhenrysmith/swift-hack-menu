//
//  QuotesViewController.swift
//  Kapost
//
//  Created by Ian Smith on 8/1/16.
//  Copyright © 2016 Kapost. All rights reserved.
//

import Cocoa
import WebKit

class MenuViewController: NSViewController {
    @IBOutlet var webView: WebView!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        updateQuote()
    }
    
    func updateQuote() {
        let url: NSURL = NSURL(string: "https://jammies.kpst.me/gallery")!
        let request = NSURLRequest(URL: url)
        webView.mainFrame.loadRequest(request)
    }
}
