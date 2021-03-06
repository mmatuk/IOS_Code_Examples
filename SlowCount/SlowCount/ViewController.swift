//
//  ViewController.swift
//  SlowCount
//
//  Created by csit267-8 on 12/1/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var theCount: UILabel!
    var count: Int = 0
    var counterTask: UIBackgroundTaskIdentifier!
    var theTimer: NSTimer!
    
    
    func countUp() {
        if count==1000 {
            theTimer.invalidate()
            UIApplication.sharedApplication().endBackgroundTask(counterTask)
        } else {
            count++
            theCount.text="\(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterTask =
            UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
                // If you’re worried about exceeding 10 minutes, handle it here
            })
        
        theTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
            selector: "countUp", userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

