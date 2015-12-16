//
//  ViewController.swift
//  Gestures
//
//  Created by csit267-8 on 11/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var originalRect: CGRect!
    var lastImageLocation: CGPoint!
    
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var panView: UIView!
    
    @IBAction func foundTap(sender: AnyObject) {
        outputLabel.text="Tapped"
    }
    
    @IBAction func foundPress(sender: AnyObject) {
        outputLabel.text="Pressed"
    }
    
    @IBAction func foundPan(sender: AnyObject) {
        var recognizer: UIPanGestureRecognizer
        recognizer=sender as! UIPanGestureRecognizer
        let translation = recognizer.translationInView(self.view)
        
        if let view = imageView {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func foundRotation(sender: AnyObject) {
        var recongnizer: UIRotationGestureRecognizer
        var feedback: String
        var rotation: CGFloat
        recongnizer=sender as! UIRotationGestureRecognizer
        rotation=recongnizer.rotation
        
        feedback=String(format: "Rotated, Radians: %1.2f, Velocity: %1.2f", Float(recongnizer.rotation), Float(recongnizer.velocity))
        outputLabel.text=feedback
        
        if let view = imageView {
            view.transform = CGAffineTransformRotate(view.transform, recongnizer.rotation)
            recongnizer.rotation = 0
        }
    }
    
    @IBAction func foundPinch(sender: AnyObject) {
        var recongnizer: UIPinchGestureRecognizer
        var feedback: String
        var scale: CGFloat
        
        recongnizer=sender as! UIPinchGestureRecognizer
        scale=recongnizer.scale
        
        if let view = imageView {
            view.transform = CGAffineTransformScale(view.transform,
                scale, scale)
            recongnizer.scale = 1
        
        }

        feedback=String(format: "Pinched, Scale: %1.2f, Velocity: %1.2f", Float(recongnizer.scale), Float(recongnizer.velocity))
        outputLabel.text=feedback

    }
    
    @IBAction func foundSwipe(sender: AnyObject) {
        outputLabel.text="Swiped"
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == UIEventSubtype.MotionShake
        {
            outputLabel.text="Shaking things up!"
            imageView.transform=CGAffineTransformIdentity
            imageView.frame=originalRect
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.becomeFirstResponder()
        originalRect = imageView.frame
        imageView.removeConstraints(imageView.constraints)
        
        //Add for a programmatically created imageview
        /*
        var tempImageView: UIImageView
        tempImageView=UIImageView(image: UIImage(named: "flower.png"))
        tempImageView.frame=originalRect
        view.addSubview(tempImageView)
        
        self.imageView=tempImageView
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

