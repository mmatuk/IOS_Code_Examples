//
//  ViewController.swift
//  FieldButtonFun
//
//  Created by Matt Matuk on 10/7/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//
//  This app allows the user to insert custom words and numbers into generated storys.
//  
//  Displays Skills:
//      -Sound effects
//      -arrays
//      -segmented control
//      -multiple user input and string manipulation
//      -UiTextView changing Bold and size thru code
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var thePlace: UITextField!
    @IBOutlet weak var theVerb: UITextField!
    @IBOutlet weak var theNumber: UITextField!
    @IBOutlet weak var theTemplate: UITextView!
    @IBOutlet weak var thePerson: UITextField!
    @IBOutlet weak var theFood: UITextField!
    @IBOutlet weak var textSize: UITextField!
    @IBOutlet weak var storyChoice: UISegmentedControl!
    @IBOutlet weak var boldSwitch: UISwitch!
    
    // array for stories
    let stories: [String] =
    [
        "<person> descended upon <place>. <person> vowed to <verb> night and day, until all <number> <food> were gone and the <place> was left empty. The <place> would never be the same again.",
        "<person> decided to set out on an adventure to <place>, but something went wrong. <person> could not leave until eatings all <number> <food> that was left sitting out all night. So <person> decided to <verb> the <food> and then left for <place>.",
        "<person> wants to do <verb> at the <place>, but is not good enough to do <verb>. So <person> decides to get strength from eating <food> and doing <number> pushups.",
        "<person> will be <verb> all <number> pieces of <food> at <place> tonight."
        
    ]
    
    var StoryText: String!
    
    // Generates the stroy from what the user entered
    @IBAction func createStory(sender: AnyObject) {
        playGenerateSound()
        StoryText = theTemplate.text
        
        // only replaces the word if the textfield is not empty
        if (thePlace.text != "")
        {
        StoryText = StoryText.stringByReplacingOccurrencesOfString("<place>", withString: thePlace.text!)
        }
        
        if (theVerb.text != "")
        {
        StoryText = StoryText.stringByReplacingOccurrencesOfString("<verb>", withString: theVerb.text!)
        }
        
        if (theNumber.text != "")
        {
        StoryText = StoryText.stringByReplacingOccurrencesOfString("<number>", withString: theNumber.text!)
        }
        
        if (thePerson.text != "")
        {
        StoryText = StoryText.stringByReplacingOccurrencesOfString("<person>", withString: thePerson.text!)
        }
        
        if (theFood.text != "")
        {
        StoryText = StoryText.stringByReplacingOccurrencesOfString("<food>", withString: theFood.text!)
        }
    }
    
    // User picks one of four stories from the array using the segmented control
    @IBAction func pickStory(sender: AnyObject) {
        playClickSound()
        theTemplate.text = stories[storyChoice.selectedSegmentIndex]
    }
    
    /*
    // user sets textview to bold or no bold witht the use of a switch
    @IBAction func setBold(sender: AnyObject) {
        playSwipeSound()
        
        // switches the text depending on if bold is set or not
        if (boldSwitch.on)
        {
            theStory.font = UIFont.boldSystemFontOfSize(theStory.font!.pointSize)
            theTemplate.font = UIFont.boldSystemFontOfSize(theTemplate.font!.pointSize)
        }
        else
        {
            theStory.font = UIFont.systemFontOfSize(theStory.font!.pointSize)
            theTemplate.font = UIFont.systemFontOfSize(theTemplate.font!.pointSize)
        }
        
    }
    
    // user changes the text size of the text views that are displaying the story. User inputs the size from a UITextField
    @IBAction func setTextSze(sender: AnyObject) {
        // makes sure a number was entered
        if (textSize.text != "")
        {
            theStory.font = UIFont(name: theStory.font!.fontName, size: CGFloat((textSize.text as! NSString).floatValue))
            theTemplate.font = UIFont(name: theStory.font!.fontName, size: CGFloat((textSize.text as! NSString).floatValue))
        }

    }*/
    
    // hides keyboard for all textfields
    @IBAction func hideKeyboard(sender: AnyObject) {
        thePlace.resignFirstResponder()
        theVerb.resignFirstResponder()
        theNumber.resignFirstResponder()
        theTemplate.resignFirstResponder()
        thePerson.resignFirstResponder()
        theFood.resignFirstResponder()
        //textSize.resignFirstResponder()
    }
    
    // plays the click sound
    func playClickSound()
    {
        var soundID: SystemSoundID = 0
        let soundFile: String = NSBundle.mainBundle().pathForResource("click", ofType: "wav")!
        let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlayAlertSound(soundID)
    }
    
    // plays the swip sound
    func playSwipeSound()
    {
        var soundID: SystemSoundID = 0
        let soundFile: String = NSBundle.mainBundle().pathForResource("swipe", ofType: "wav")!
        let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlayAlertSound(soundID)
    }
    
    // plays the generate sound
    func playGenerateSound()
    {
        var soundID: SystemSoundID = 0
        let soundFile: String = NSBundle.mainBundle().pathForResource("generate", ofType: "wav")!
        let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlayAlertSound(soundID)
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

