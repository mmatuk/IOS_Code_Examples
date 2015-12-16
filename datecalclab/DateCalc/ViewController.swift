//
//  ViewController.swift
//  DateCalc
//
//  Created by csit267-8 on 10/27/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    func calculateDateDifference(chosenDate: NSDate)
    {
        let todaysDate: NSDate = NSDate()
        let difference: NSTimeInterval = todaysDate.timeIntervalSinceDate(chosenDate) / 86400
        
       // NSLog("%@", NSDate().timeIntervalSinceDate(NSDate.distantFuture() as NSDate))
        
        let dateFormat: NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "MMMM d, yyyy hh:mm:ssa"
        
        let todaysDateString: String = dateFormat.stringFromDate(todaysDate)
        let chosenDateString: String = dateFormat.stringFromDate(chosenDate)
        
        let differenceOutPut: String = NSString(format: "Difference between chosen date (%@) and today (%@) in days: %1.2f", chosenDateString, todaysDateString, fabs(difference)) as String
        
        outputLabel.text = differenceOutPut
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

