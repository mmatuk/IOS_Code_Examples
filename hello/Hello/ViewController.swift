//
//  ViewController.swift
//  Hello
//
//  Created by csit267-8 on 11/11/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let theLabel: UILabel = UILabel()
    
    func initInterface()
    {
        theLabel.text = "Hello Xcode"
        
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
            theLabel.frame=CGRectMake(screenWidth/2-40, screenHeight/2-10, 200.0, 20.0)
        }
        else
        {
            theLabel.frame=CGRectMake(screenWidth/2-40, 20.0, 200.0, 20.0)
        }
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

