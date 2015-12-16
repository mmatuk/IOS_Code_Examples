//: Playground - noun: a place where people can play
//
//  ViewController.swift
//  ColorTilt
//
//  Created by csit267-8 on 11/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let kRad2Deg:Double = 57.2957795
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var toggleAccelerometer: UISwitch!
    @IBOutlet var toggleGyroscope: UISwitch!
    @IBOutlet var toggleMotion: UISwitch!
    
    @IBOutlet var rollOutput: UILabel!
    @IBOutlet var pitchOutput: UILabel!
    @IBOutlet var yawOutput: UILabel!
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    var canChangeColor = true
    
    @IBAction func controlHardware(sender: AnyObject) {
        if toggleMotion.on {
            
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {
                (motion, error) in self.doAttitude(motion!.attitude)
                
                if self.toggleAccelerometer.on {
                    self.doAcceleration(motion!.userAcceleration)
                    
                }
                if self.toggleGyroscope.on {
                    self.doRotation(motion!.rotationRate)
                }
            })
        } else {
            toggleGyroscope.on = false
            toggleAccelerometer.on = false
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func doAttitude(attitude: CMAttitude)
    {
        rollOutput.text = String(format: "%.0f",attitude.roll*kRad2Deg)
        pitchOutput.text = String(format: "%.0f",attitude.pitch*kRad2Deg)
        yawOutput.text = String(format: "%.0f",attitude.yaw*kRad2Deg)
        
        if !toggleGyroscope.on {
            colorView.alpha=CGFloat(fabs(attitude.pitch))
        }
    }
    
    func doAcceleration(acceleration: CMAcceleration)
    {
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        if (acceleration.x > 1.3) {
            if (canChangeColor) {
                canChangeColor = false
                colorView.backgroundColor = UIColor.greenColor()
                dispatch_after(time, dispatch_get_main_queue())
                    {
                        self.canChangeColor = true
                }
            }
        } else if (acceleration.x < -1.3) {
            if (canChangeColor) {
                colorView.backgroundColor = UIColor.orangeColor()
            }
        }
        
        /*else if (acceleration.y > 1.3) {
        colorView.backgroundColor = UIColor.redColor()
        } else if (acceleration.y < -1.3) {
        colorView.backgroundColor = UIColor.blackColor()
        } else if (acceleration.z > 1.3) {
        colorView.backgroundColor = UIColor.yellowColor()
        } else if (acceleration.z < -1.3) {
        colorView.backgroundColor = UIColor.purpleColor()
        }*/
        
    }
    
    
    func doRotation(rotation: CMRotationRate)
    {
        var value: Double = fabs(rotation.x)+fabs(rotation.y)+fabs(rotation.z)/12.5;
        if (value > 1.0) { value = 1.0;}
        colorView.alpha = CGFloat(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        motionManager.deviceMotionUpdateInterval = 0.01
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

