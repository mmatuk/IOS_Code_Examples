//
//  ViewController.swift
//  BackgroundColor
//
//  Created by csit267-8 on 11/9/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kOnOffToggle="onOff"
    let kHueSetting="hue"

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var hueSlider: UISlider!
    
    @IBAction func setBackgroundColor(sender: AnyObject?) {
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool(toggleSwitch.on, forKey: kOnOffToggle)
        userDefaults.setFloat(hueSlider.value, forKey: kHueSetting)
        userDefaults.synchronize()
        
        if toggleSwitch.on
        {
            view.backgroundColor=UIColor(hue: CGFloat(hueSlider.value), saturation: 0.75, brightness: 0.75, alpha: 1.0)
        }
        else
        {
            view.backgroundColor=UIColor.whiteColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        hueSlider.value=userDefaults.floatForKey(kHueSetting)
        toggleSwitch.on=userDefaults.boolForKey(kOnOffToggle)
        
        setBackgroundColor(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

