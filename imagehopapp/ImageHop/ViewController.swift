//
//  ViewController.swift
//  ImageHop
//
//  Created by csit267-8 on 10/12/15.
//  Copyright (c) 2015 ccbcmd. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var count: Int = 0
    var counterTask: UIBackgroundTaskIdentifier!
    var theTimer: NSTimer!
    
    var audioPlayer: AVAudioPlayer!
    
    @IBAction func toggleAnimation(sender: AnyObject) {
        if (bunnyView1.isAnimating())
        {
            bunnyView1.stopAnimating()
            bunnyView2.stopAnimating()
            bunnyView3.stopAnimating()
            bunnyView4.stopAnimating()
            bunnyView5.stopAnimating()
            toggleButton.setTitle("Hop!", forState: UIControlState.Normal)
        }
        else
        {
            bunnyView1.startAnimating()
            bunnyView2.startAnimating()
            bunnyView3.startAnimating()
            bunnyView4.startAnimating()
            bunnyView5.startAnimating()
            toggleButton.setTitle("Sit Still!", forState: UIControlState.Normal)
        }
    }

    @IBAction func setSpeed(sender: AnyObject?) {
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
        
    }
    
    @IBAction func setIncrement(sender: AnyObject) {
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
    
    func countUp() {
        if count==1000000 {
            theTimer.invalidate()
            UIApplication.sharedApplication().endBackgroundTask(counterTask)
        } else {
            count++
        }
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
        bunnyView1.animationDuration=1.0
        bunnyView2.animationDuration=1.0
        bunnyView3.animationDuration=1.0
        bunnyView4.animationDuration=1.0
        bunnyView5.animationDuration=1.0
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            let soundFile: NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("game", ofType: "wav")!)
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundFile)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
        catch
        {}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func stop()
    {
        UIApplication.sharedApplication().endBackgroundTask(counterTask)
        theTimer.invalidate()
    }
    
    func getCount() -> Int
    {
        return count
    }
}

