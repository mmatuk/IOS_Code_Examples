//
//  ViewController.swift
//  AllInCode
//
//  Created by csit267-8 on 11/9/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let buttonA: UIButton = UIButton(type: UIButtonType.System) as UIButton
    let buttonB: UIButton = UIButton(type: UIButtonType.System) as UIButton
    let buttonC: UIButton = UIButton(type: UIButtonType.System) as UIButton
    let buttonD: UIButton = UIButton(type: UIButtonType.System) as UIButton

    let theLabel: UILabel = UILabel()
    
    func initInterface()
    {
        buttonA.addTarget(self, action: "handleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonA.setTitle("Button A", forState: UIControlState.Normal)
        
        buttonB.addTarget(self, action: "handleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonB.setTitle("Button B", forState: UIControlState.Normal)
        
        buttonC.addTarget(self, action: "handleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonC.setTitle("Button C", forState: UIControlState.Normal)
        
        buttonD.addTarget(self, action: "handleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonD.setTitle("Button D", forState: UIControlState.Normal)
        
        theLabel.text = "Welcome"
        
        updateInterface()
        
    }
    
    func updateInterface()
    {
        let screenWidth: CGFloat = view.bounds.size.width
        let screenHeight: CGFloat = view.bounds.size.height
        
        for subview in view.subviews
        {
            subview.removeFromSuperview()
        }
        
        if interfaceOrientation == UIInterfaceOrientation.Portrait || interfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown
        {
            buttonA.frame = CGRectMake(20.0,20.0,screenWidth-40.0,screenHeight/2-40.0)
            buttonC.frame = CGRectMake(20.0,screenHeight/2+20,screenWidth-40.0,screenHeight/2-40.0)
            buttonB.frame = CGRectMake(((screenHeight/4)), screenWidth/2, screenWidth-40.0, screenHeight/2-40.0)
            buttonD.frame = CGRectMake(-((screenHeight/4)-40), screenWidth/2, screenWidth-40.0, screenHeight/2-40.0)
            theLabel.frame=CGRectMake(screenWidth/2-40, screenHeight/2-10, 200.0, 20.0)
        }
        else
        {
            buttonA.frame = CGRectMake(-screenWidth * (1/3),60.0,screenWidth-40.0,screenHeight/2-40.0)
            buttonB.frame = CGRectMake(-screenWidth * (1/3),screenHeight/2+30,screenWidth-40.0,screenHeight/2-40.0)
            buttonD.frame = CGRectMake(screenWidth * (1/3),screenHeight/2+30,screenWidth-40.0,screenHeight/2-40.0)
            buttonC.frame = CGRectMake(screenWidth * (1/3),60.0,screenWidth-40.0,screenHeight/2-40.0)
            theLabel.frame=CGRectMake(screenWidth/2-40, 20.0, 200.0, 20.0)
        }
        
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        view.addSubview(buttonC)
        view.addSubview(buttonD)
        view.addSubview(theLabel)
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        updateInterface()
    }
    
    func handleButton(sender:UIButton!)
    {
        theLabel.text=sender.currentTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

