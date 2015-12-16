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
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    var right: Int = 0
    var wrong: Int = 0

    func displayAnimal(chosenAnimal: String, withSound chosenSound: String, fromComponent chosenComponent: String, rightWrong: Bool)
    {
        if rightWrong == true
        {
            outputLabel.text = "Correct \(chosenComponent) \(chosenAnimal) and the sound \(chosenSound) go together!"
            right++

        }
        else
        {
            outputLabel.text = "Wrong \(chosenComponent) \(chosenAnimal) and the sound \(chosenSound) do not go together!"
            wrong++
        }
        updateView()
    }
    
    func updateView()
    {
        rightLabel.text = "\(right)"
        wrongLabel.text = "\(wrong)"
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

