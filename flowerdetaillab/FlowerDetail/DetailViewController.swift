//
//  DetailViewController.swift
//  FlowerDetail
//
//  Created by csit267-8 on 11/6/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var DetailWebView: UIWebView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            let detailURL: NSURL = NSURL(string: detail["url"] as! String)!
            if let webview = DetailWebView
            {
                webview.loadRequest(NSURLRequest(URL: detailURL))
                navigationItem.title = detail["name"] as! String!
                detailDescriptionLabel.hidden = true
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

