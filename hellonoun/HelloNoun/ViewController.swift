//
//  ViewController.swift            Created By: Matt Matuk
//  HelloNoun
//
//  Created by csit267-8 on 9/23/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate
{

    @IBOutlet weak var userOutput: UITextView!
    @IBOutlet weak var userNoun: UITextField!
    @IBOutlet weak var userVerb: UITextField!
    
    var strSentanceBeforeNoun = "The "
    var strSentanceBetweenNounVerb = " is going to be "
    var strSentanceAfterVerb = " tomorrow because something said to do that."
    var strUserNoun = ""
    var strUserVerb = ""
    
    
    @IBAction func setNoun(sender: AnyObject)
    {
        if (!userNoun.text.isEmpty)
        {
            strUserNoun = userNoun.text
        
            if (strUserVerb == "")
            {
                userOutput.text = strSentanceBeforeNoun + strUserNoun + strSentanceBetweenNounVerb + "____" + strSentanceAfterVerb
            }
            else
            {
                userOutput.text = strSentanceBeforeNoun + strUserNoun + strSentanceBetweenNounVerb + strUserVerb + strSentanceAfterVerb
            }
            /*if (userStr.substringWithRange(Range<String.Index>(start: advance(userStr.endIndex, -3), end: advance(userStr.endIndex, 0))) == "ing")
            {
                userOutput.text = "ing"
            }
            */
        }
    }
    
    @IBAction func setVerb(sender: AnyObject)
    {
        if (!userVerb.text.isEmpty)
        {
            strUserVerb = userVerb.text
        
            if (strUserNoun == "")
            {
                userOutput.text = strSentanceBeforeNoun + "____" + strSentanceBetweenNounVerb +  strUserVerb + strSentanceAfterVerb
            }
            else
            {
                userOutput.text = strSentanceBeforeNoun + strUserNoun + strSentanceBetweenNounVerb + strUserVerb + strSentanceAfterVerb
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userNoun.delegate = self
        userVerb.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

