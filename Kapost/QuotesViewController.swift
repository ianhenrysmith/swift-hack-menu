//
//  QuotesViewController.swift
//  Kapost
//
//  Created by Ian Smith on 8/1/16.
//  Copyright © 2016 Kapost. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {
    @IBOutlet var textLabel: NSTextField!
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        currentQuoteIndex = 0
    }
    
    func setContent(jsonResult: NSData) {
        var content = [String]()
        print("setContent")
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonResult, options: .AllowFragments)
            
            if let posts = json["response"] as? [[String: AnyObject]] {
                for post in posts {
                    if let title = post["title"] as? String {
                        content.append(title)
                    }
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        
        print(content) // ["Bloxus test", "Manila Test"]
    }
    
    func fetchContent() {
        let url: NSURL = NSURL(string: "https://jammies.kpst.me/api/v1/content")!
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request1.HTTPMethod = "GET"
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            do {
                self.setContent(data!)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
    }
    
    func updateQuote() {
        textLabel.stringValue = String(quotes[currentQuoteIndex])
        
        fetchContent()
    }

    @IBAction func goLeft(sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func goRight(sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
}