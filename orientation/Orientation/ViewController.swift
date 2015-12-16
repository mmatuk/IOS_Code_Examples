//
//  ViewController.swift
//  Orientation
//
//  Created by csit267-8 on 11/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var orientationLabel: UILabel!
    
    func orientationChanged(notification: NSNotification)
    {
        let orientation: UIDeviceOrientation = UIDevice.currentDevice().orientation
        
        switch(orientation)
        {
        case UIDeviceOrientation.FaceUp:
            orientationLabel.text = "Face Up"
        case UIDeviceOrientation.FaceDown:
            orientationLabel.text = "Face Down"
        case UIDeviceOrientation.Portrait:
            orientationLabel.text = "Standing Up"
        case UIDeviceOrientation.PortraitUpsideDown:
            orientationLabel.text = "Upside Down"
        case UIDeviceOrientation.LandscapeLeft:
            orientationLabel.text = "Left Side"
        case UIDeviceOrientation.LandscapeRight:
            orientationLabel.text = "Right Side"
        default:
            orientationLabel.text = "Unkown"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: "UIDeviceOrientationDidChangeNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

