//
//  GenericViewController.swift
//  LetsTab
//
//  Created by csit267-8 on 11/4/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounts()
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
