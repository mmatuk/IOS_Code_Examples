//
//  StoryViewController.swift
//  ModelEditorApp
//
//  Created by csit267-8 on 10/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var story: UITextView!
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        story.text = (presentingViewController as! ViewController).StoryText

    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
