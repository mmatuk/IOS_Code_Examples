//
//  EditorViewController.swift
//  ModelEditor
//
//  Created by csit267-8 on 10/27/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func updateEditor(sender: AnyObject) {
        (presentingViewController as! ViewController).emailLabel.text = emailField.text
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        emailField.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        emailField.text = (presentingViewController as! ViewController).emailLabel.text
        
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSizeMake(240,160)
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
