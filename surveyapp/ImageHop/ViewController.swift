//
//  ViewController.swift
//  ImageHop
//
//  Created by csit267-8 on 10/12/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bunnyView1: UIImageView!
    @IBOutlet weak var bunnyView2: UIImageView!
    @IBOutlet weak var bunnyView3: UIImageView!
    @IBOutlet weak var bunnyView4: UIImageView!
    @IBOutlet weak var bunnyView5: UIImageView!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedStepper: UIStepper!
    @IBOutlet weak var hopsPerSecond: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var userSpeed: UITextField!
    
    var kSpeed = "speed"
    var konOff = "onoff"
    var kbunny1 = "b1"
    var kbunny2 = "b2"
    var kbunny3 = "b3"
    var kbunny4 = "b4"
    var kbunny5 = "b5"
    
    @IBAction func toggleAnimation(sender: AnyObject) {
        if (bunnyView1.isAnimating())
        {
            bunnyView1.stopAnimating()
            bunnyView2.stopAnimating()
            bunnyView3.stopAnimating()
            bunnyView4.stopAnimating()
            bunnyView5.stopAnimating()
            toggleButton.setTitle("Hop!", forState: UIControlState.Normal)
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setBool(false, forKey: konOff)
            userDefaults.synchronize()
        }
        else
        {
            bunnyView1.startAnimating()
            bunnyView2.startAnimating()
            bunnyView3.startAnimating()
            bunnyView4.startAnimating()
            bunnyView5.startAnimating()
            toggleButton.setTitle("Sit Still!", forState: UIControlState.Normal)
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setBool(true, forKey: konOff)
            userDefaults.synchronize()
        }
    }

    @IBAction func setSpeed(sender: AnyObject?)
    {
        bunnyView1.animationDuration=Double(1.0/speedSlider.value)
        bunnyView2.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
        bunnyView3.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
        bunnyView4.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
        bunnyView5.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
        
        bunnyView1.startAnimating()
        bunnyView2.startAnimating()
        bunnyView3.startAnimating()
        bunnyView4.startAnimating()
        bunnyView5.startAnimating()
        
        toggleButton.setTitle("Sit Still!", forState: UIControlState.Normal)
        
        let hopRateString = String (format: "%1.2f hps", 1/(1/self.speedSlider.value))
        hopsPerSecond.text=hopRateString
        
        speedStepper.value = (round(Double(speedSlider.value) / 0.25)*0.25) //updates current stepper location to the slidder number
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: konOff)
        userDefaults.setFloat(speedSlider.value, forKey: kSpeed)
        userDefaults.setDouble(bunnyView1.animationDuration, forKey: kbunny1)
        userDefaults.setDouble(bunnyView2.animationDuration, forKey: kbunny2)
        userDefaults.setDouble(bunnyView3.animationDuration, forKey: kbunny3)
        userDefaults.setDouble(bunnyView4.animationDuration, forKey: kbunny4)
        userDefaults.setDouble(bunnyView5.animationDuration, forKey: kbunny5)
        userDefaults.synchronize()
    }
    
    @IBAction func setIncrement(sender: AnyObject)
    {
        speedSlider.value=Float(speedStepper.value)
        setSpeed(nil)
    }
    
    @IBAction func setSpeedFromUser(sender: AnyObject) {
        var speed = ((userSpeed.text as! NSString).doubleValue)
        
        if ((speed >= 0.25) && (speed <= 20.75))
        {
            bunnyView1.animationDuration=Double(1.0/speed)
            bunnyView2.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
            bunnyView3.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
            bunnyView4.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
            bunnyView5.animationDuration=bunnyView1.animationDuration+Double(arc4random_uniform(10))/10.0
        
            bunnyView1.startAnimating()
            bunnyView2.startAnimating()
            bunnyView3.startAnimating()
            bunnyView4.startAnimating()
            bunnyView5.startAnimating()
        
            toggleButton.setTitle("Sit Still!", forState: UIControlState.Normal)
        
            let hopRateString = String (format: "%1.2f hps", 1/(1/speed))
            hopsPerSecond.text=hopRateString
        
            speedSlider.value=Float(speed) // sets slider to user value

            speedStepper.value = (round(Double(speedSlider.value) / 0.25)*0.25) //updates current stepper location to the slidder number
            
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setBool(true, forKey: konOff)
            userDefaults.setFloat(speedSlider.value, forKey: kSpeed)
            userDefaults.setDouble(bunnyView1.animationDuration, forKey: kbunny1)
            userDefaults.setDouble(bunnyView2.animationDuration, forKey: kbunny2)
            userDefaults.setDouble(bunnyView3.animationDuration, forKey: kbunny3)
            userDefaults.setDouble(bunnyView4.animationDuration, forKey: kbunny4)
            userDefaults.setDouble(bunnyView5.animationDuration, forKey: kbunny5)
            userDefaults.synchronize()
        }
        else
        {
            showAlert(nil)
        }
    }

    
    func showAlert(sender: AnyObject?)
    {
        let alertController = UIAlertController(title: "Wrong Speed", message: "Please enter a value between .25 and 20.75 for the speed.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        userSpeed.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hopAnimation: [UIImage] =
        [
            UIImage(named: "frame-1")!,
            UIImage(named: "frame-2")!,
            UIImage(named: "frame-3")!,
            UIImage(named: "frame-4")!,
            UIImage(named: "frame-5")!,
            UIImage(named: "frame-6")!,
            UIImage(named: "frame-7")!,
            UIImage(named: "frame-8")!,
            UIImage(named: "frame-9")!,
            UIImage(named: "frame-10")!,
            UIImage(named: "frame-11")!,
            UIImage(named: "frame-12")!,
            UIImage(named: "frame-13")!,
            UIImage(named: "frame-14")!,
            UIImage(named: "frame-15")!,
            UIImage(named: "frame-16")!,
            UIImage(named: "frame-17")!,
            UIImage(named: "frame-18")!,
            UIImage(named: "frame-19")!,
            UIImage(named: "frame-20")!
        ]

        bunnyView1.animationImages=hopAnimation
        bunnyView2.animationImages=hopAnimation
        bunnyView3.animationImages=hopAnimation
        bunnyView4.animationImages=hopAnimation
        bunnyView5.animationImages=hopAnimation
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        bunnyView1.animationDuration=userDefaults.doubleForKey(kbunny1)
        bunnyView2.animationDuration=userDefaults.doubleForKey(kbunny2)
        bunnyView3.animationDuration=userDefaults.doubleForKey(kbunny3)
        bunnyView4.animationDuration=userDefaults.doubleForKey(kbunny4)
        bunnyView5.animationDuration=userDefaults.doubleForKey(kbunny5)
        
        speedSlider.value = userDefaults.floatForKey(kSpeed)
        
        let speed = userDefaults.floatForKey(kSpeed)
        let hopRateString = String (format: "%1.2f hps", 1/(1/speed))
        hopsPerSecond.text=hopRateString
        
        if (userDefaults.boolForKey(konOff))
        {
            bunnyView1.startAnimating()
            bunnyView2.startAnimating()
            bunnyView3.startAnimating()
            bunnyView4.startAnimating()
            bunnyView5.startAnimating()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}

