//
//  DateChooserViewController.swift
//  DateCalc
//
//  Created by csit267-8 on 10/27/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class DateChooserViewController: UIViewController {
    

    @IBAction func dismissDateChooser(sender: AnyObject) {
        (presentingViewController as! ViewController).calculateDateDifference()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func setDateTime(sender: AnyObject) {
        (presentingViewController as! ViewController).firstDate = (sender as! UIDatePicker).date
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (presentingViewController as! ViewController).calculateDateDifference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSizeMake(340,380)
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
