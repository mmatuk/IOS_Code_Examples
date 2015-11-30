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
    let kSaturation="sat"
    let kBrightness="brightness"
    let kAlpha="alpha"

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var hueSlider: UISlider!
    @IBOutlet var brightnessSlider: UISlider!
    @IBOutlet var alphaSlider: UISlider!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var alphaLabel: UILabel!
    
    func update()
    {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        hueSlider.value=userDefaults.floatForKey(kHueSetting)
        saturationSlider.value=userDefaults.floatForKey(kSaturation)
        alphaSlider.value=userDefaults.floatForKey(kAlpha)
        brightnessSlider.value=userDefaults.floatForKey(kBrightness)
        toggleSwitch.on=userDefaults.boolForKey(kOnOffToggle)
        
        setBackgroundColor(toggleSwitch)
    }
    @IBAction func setBackgroundColor(sender: AnyObject?) {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setBool(toggleSwitch.on, forKey: kOnOffToggle)
        userDefaults.setFloat(hueSlider.value, forKey: kHueSetting)
        userDefaults.setFloat(alphaSlider.value, forKey: kAlpha)
        userDefaults.setFloat(brightnessSlider.value, forKey: kBrightness)
        userDefaults.setFloat(saturationSlider.value, forKey: kSaturation)
        userDefaults.synchronize()
        
        if toggleSwitch.on
        {
            view.backgroundColor=UIColor(hue: CGFloat(hueSlider.value), saturation: CGFloat(saturationSlider.value), brightness: CGFloat(brightnessSlider.value), alpha: CGFloat(alphaSlider.value))
        }
        else
        {
            view.backgroundColor=UIColor.whiteColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        appDel.myViewController = self
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        hueSlider.value=userDefaults.floatForKey(kHueSetting)
        saturationSlider.value=userDefaults.floatForKey(kSaturation)
        alphaSlider.value=userDefaults.floatForKey(kAlpha)
        brightnessSlider.value=userDefaults.floatForKey(kBrightness)
        toggleSwitch.on=userDefaults.boolForKey(kOnOffToggle)
        
        setBackgroundColor(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

