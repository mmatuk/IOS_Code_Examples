//
//  ViewController.swift
//  CustomPicker
//
//  Created by csit267-8 on 10/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLabel: UILabel!

    func displayAnimal(chosenAnimal: String, withSound chosenSound: String, fromComponent chosenComponent: String)
    {
        outputLabel.text = "You Changed \(chosenComponent) \(chosenAnimal) and the sound \(chosenSound)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

