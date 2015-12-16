//
//  ViewController.swift
//  FlowerWebLab
//
//  Created by csit267-8 on 10/12/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flowerDetailView: UIWebView!
    @IBOutlet weak var flowerView: UIWebView!
    @IBOutlet weak var colorChoice: UISegmentedControl!
    @IBOutlet weak var detail: UISwitch!
    
    @IBAction func getFlower(sender: AnyObject?) {
        var imageURL: NSURL
        var detailURL: NSURL
        var imageURLString: String
        var detailURLString: String
        var color: String
        let sessionID: Int=random()%50000
        
        color = colorChoice.titleForSegmentAtIndex(colorChoice.selectedSegmentIndex)!
        
        imageURLString = "http://www.floraphotographs.com/showrandomios.php?color=\(color)&session=\(sessionID)"
        detailURLString = "http://www.floraphotographs.com/detailios.php?session=\(sessionID)"
        
        imageURL=NSURL(string: imageURLString)!
        detailURL=NSURL(string: detailURLString)!
        
        flowerView.loadRequest(NSURLRequest(URL: imageURL))
        flowerDetailView.loadRequest(NSURLRequest(URL: detailURL))
        
        colorChoice
    }

    @IBAction func toggleFlowerDetails(sender: AnyObject) {
        flowerDetailView.hidden = !detail.on
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flowerDetailView.hidden = true
        getFlower(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

