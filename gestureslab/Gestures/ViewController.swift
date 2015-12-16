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
    
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func foundTap(sender: AnyObject) {
        outputLabel.text="Tapped"
    }
    
    @IBAction func foundRotation(sender: AnyObject) {
        var recongnizer: UIRotationGestureRecognizer
        var feedback: String
        var rotation: CGFloat
        
        recongnizer=sender as! UIRotationGestureRecognizer
        rotation=recongnizer.rotation
        
        feedback=String(format: "Rotated, Radians: %1.2f, Velocity: %1.2f", Float(recongnizer.rotation), Float(recongnizer.velocity))
        outputLabel.text=feedback
        imageView.transform=CGAffineTransformMakeRotation(rotation)
    }
    
    @IBAction func foundPinch(sender: AnyObject) {
        var recongnizer: UIPinchGestureRecognizer
        var feedback: String
        var scale: CGFloat
        
        recongnizer=sender as! UIPinchGestureRecognizer
        scale=recongnizer.scale
        imageView.transform = CGAffineTransformMakeRotation(0.0)
        
        feedback=String(format: "Pinched, Scale: %1.2f, Velocity: %1.2f", Float(recongnizer.scale), Float(recongnizer.velocity))
        outputLabel.text=feedback
        imageView.frame=CGRectMake(self.originalRect.origin.x, originalRect.origin.y, originalRect.size.width*scale, originalRect.size.height*scale)
    }
    
    @IBAction func foundSwipe(sender: AnyObject) {
        outputLabel.text="Swiped"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        originalRect = imageView.frame
        
        var tempImageView: UIImageView
        tempImageView=UIImageView(image: UIImage(named: "flower.png"))
        tempImageView.frame=originalRect
        view.addSubview(tempImageView)
        
        self.imageView=tempImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

