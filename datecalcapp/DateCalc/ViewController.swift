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
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    
    var firstDate: NSDate = NSDate()
    var secondDate: NSDate = NSDate()
    
    let dateFormat: NSDateFormatter = NSDateFormatter()
    
    func calculateDateDifference()
    {
        firstDateLabel.text = dateFormat.stringFromDate(firstDate)
        secondDateLabel.text = dateFormat.stringFromDate(secondDate)
        
        let difference: NSTimeInterval = firstDate.timeIntervalSinceDate(secondDate) / 86400
        
        let differenceOutPut: String = NSString(format: "Difference in days is: %1.2f", fabs(difference)) as String
        
        outputLabel.text = differenceOutPut
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateFormat.dateFormat = "MMMM d, yyyy hh:mm:ssa"
        firstDateLabel.text = dateFormat.stringFromDate(NSDate())
        secondDateLabel.text = dateFormat.stringFromDate(NSDate())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

