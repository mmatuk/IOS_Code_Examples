//
//  GenericViewController.swift
//  LetsTab
//
//  Created by csit267-8 on 11/4/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    
    @IBOutlet var squareInput: UITextField!
    @IBOutlet var circleInput: UITextField!
    @IBOutlet var triangleInputB: UITextField!
    @IBOutlet var triangleInputH: UITextField!
    @IBOutlet var squareArea: UILabel!
    @IBOutlet var circleArea: UILabel!
    @IBOutlet var triangleArea: UILabel!
    @IBOutlet weak var barItem: UITabBarItem!

    
    @IBAction func calculateArea(sender: AnyObject) {
        let aString = squareInput.text
        let rString = circleInput.text
        let bString = triangleInputB.text
        let hString = triangleInputH.text
        
        var squareAreaTotal = 0.0
        var circleAreaTotal = 0.0
        var triangleAreaTotal = 0.0
        
        if (aString != "")
        {
            (parentViewController as! CountingTabBarController).a = Double(aString!)!
        }

        if (rString != "")
        {
            (parentViewController as! CountingTabBarController).r = Double(rString!)!
        }
        
        if (bString != "")
        {
            (parentViewController as! CountingTabBarController).b = Double(bString!)!
        }
        
        if (hString != "")
        {
            (parentViewController as! CountingTabBarController).h = Double(hString!)!
        }
        let a = (parentViewController as! CountingTabBarController).a
        let r = (parentViewController as! CountingTabBarController).a
        let b = (parentViewController as! CountingTabBarController).a
        let h = (parentViewController as! CountingTabBarController).a
        
        squareAreaTotal = (a*a)
        circleAreaTotal = (M_PI * (r * r))
        triangleAreaTotal = (0.5 * b * h)
        
        squareArea.text = "\(squareAreaTotal)"
        circleArea.text = "\(circleAreaTotal)"
        triangleArea.text = "\(triangleAreaTotal)"
        
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        squareInput.resignFirstResponder()
        circleInput.resignFirstResponder()
        triangleInputB.resignFirstResponder()
        triangleInputH.resignFirstResponder()
    }
    
    /*
    @IBOutlet private weak var outputLabel: UILabel!
    @IBOutlet weak var barItem: UITabBarItem!

    @IBAction func incrementCountFirst(sender: AnyObject) {
        (parentViewController as! CountingTabBarController).firstCount++
        updateBadge()
        updateCounts()
    }
    
    @IBAction func incrementCountSecond(sender: AnyObject) {
        (parentViewController as! CountingTabBarController).secondCount++
        updateBadge()
        updateCounts()
    }
    
    @IBAction func incrementCountThird(sender: AnyObject) {
        (parentViewController as! CountingTabBarController).thirdCount++
        updateBadge()
        updateCounts()
    }
    
    func updateCounts()
    {
        let first = (parentViewController as! CountingTabBarController).firstCount
        let second = (parentViewController as! CountingTabBarController).secondCount
        let third = (parentViewController as! CountingTabBarController).thirdCount
        
        self.outputLabel.text = "First: \(first) \nSecond: \(second) \nThird: \(third)"
    }
    
    func updateBadge()
    {
        var badgeCount: Int
        if (barItem.badgeValue != nil)
        {
            badgeCount = Int(barItem.badgeValue!)!
            badgeCount++
            barItem.badgeValue=String(badgeCount)
        }
        else
        {
            barItem.badgeValue="1"
        }
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateCounts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
