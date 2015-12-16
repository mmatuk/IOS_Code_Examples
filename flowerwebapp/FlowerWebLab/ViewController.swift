//
//  ViewController.swift
//  FlowerWebLab
//
//  Created by csit267-8 on 10/12/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webSite: UITextField!
    @IBOutlet weak var fav: UISegmentedControl!
    @IBOutlet weak var flowerView: UIWebView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var background: UIView!

    var imageURLString: String!
    let favorites =
    [
        "www.google.com",
        "www.mlb.com",
        "www.gameinformer.com",
        "www.msn.com"
    ]
    
    @IBAction func back(sender: AnyObject) {
        flowerView.goBack()
        webSite.text=imageURLString
    }
    
    @IBAction func Forward(sender: AnyObject) {
        flowerView.goForward()
        webSite.text=imageURLString
    }
    
    @IBAction func getFav(sender: AnyObject) {
        var imageURL: NSURL
        var detailURL: NSURL
        var color: String
        let sessionID: Int=random()%50000
        
        imageURLString = "http://\(favorites[fav.selectedSegmentIndex])"
        
        imageURL=NSURL(string: imageURLString)!
        
        flowerView.loadRequest(NSURLRequest(URL: imageURL))
        webSite.text = imageURLString
    }
    
    @IBAction func getWebsite(sender: AnyObject?) {
        var imageURL: NSURL
        var detailURL: NSURL
        var color: String
        let sessionID: Int=random()%50000

        imageURLString = "http://\(webSite.text)"
        
        imageURL=NSURL(string: imageURLString)!
        
        flowerView.loadRequest(NSURLRequest(URL: imageURL))
        webSite.text = imageURLString
    }
    
    @IBAction func hide(sender: AnyObject) {
        back.hidden = !(sender as! UISwitch).on
        forward.hidden = !(sender as! UISwitch).on
        fav.hidden = !(sender as! UISwitch).on
        background.hidden = !(sender as! UISwitch).on

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getWebsite(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

