//
//  ViewController.swift
//  Survey
//
//  Created by csit267-8 on 11/9/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var resultsView: UITextView!
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        firstName.resignFirstResponder()
        LastName.resignFirstResponder()
        email.resignFirstResponder()
    }
    
    @IBAction func storeSurvey(sender: AnyObject) {
        let csvLine:String = "\(firstName.text!),\(LastName.text!),\(email.text!)\n"
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        let docDir:NSString=paths[0] as NSString
        
        let surveyFile:String=docDir.stringByAppendingPathComponent("surveyresults.csv")
        
        if !NSFileManager.defaultManager().fileExistsAtPath(surveyFile)
        {
            NSFileManager.defaultManager().createFileAtPath(surveyFile, contents: nil, attributes: nil)
        }
        
        let fileHandle:NSFileHandle=NSFileHandle(forUpdatingAtPath: surveyFile)!
        fileHandle.seekToEndOfFile()
        fileHandle.writeData(csvLine.dataUsingEncoding(NSUTF8StringEncoding)!)
        fileHandle.closeFile()
        
        firstName.text=""
        LastName.text=""
        email.text=""
        
        
    }
    
    @IBAction func showResults(sender: AnyObject) {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir:NSString=paths[0] as NSString
        let surveyFile:String=docDir.stringByAppendingPathComponent("surveyresults.csv")
        
        if NSFileManager.defaultManager().fileExistsAtPath(surveyFile)
        {
            let fileHandle:NSFileHandle=NSFileHandle(forReadingAtPath: surveyFile)!
            let surveyResults:NSString=NSString(data: fileHandle.availableData, encoding: NSUTF8StringEncoding)!
            fileHandle.closeFile()
            resultsView.text=surveyResults as String
        }
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

