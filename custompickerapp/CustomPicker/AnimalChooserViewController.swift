//
//  AnimalChooserViewController.swift
//  CustomPicker
//
//  Created by csit267-8 on 10/28/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class AnimalChooserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let kComponetCount: Int = 2
    let kAnimalComponet: Int = 0
    let kSoundComponet: Int = 1

    var animalNames: [String] = []
    var animalSounds: [String] = []
    var animalImages: [UIImageView] = []
    
    var chosenAnimal: Int = 0
    var chosenSound: Int = 0
    var won: Bool = false

    @IBAction func dismissAnimalChooser(sender: AnyObject) {
        let initialView = (presentingViewController as! ViewController)
        determineWon()
        initialView.displayAnimal(animalNames[chosenAnimal], withSound: animalSounds[chosenSound], fromComponent: "the Animal", rightWrong: won)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func determineWon()
    {
            if chosenSound == 6 && chosenAnimal == 0
            {
                won = true
            }
            if chosenSound == 5 && chosenAnimal == 1
            {
                won = true
            }
            if chosenSound == 4 && chosenAnimal == 2
            {
                won = true
            }
            if chosenSound == 3 && chosenAnimal == 3
            {
                won = true
            }
            if chosenSound == 2 && chosenAnimal == 4
            {
                won = true
            }
            if chosenSound == 1 && chosenAnimal == 5
            {
                won = true
            }
            if chosenSound == 0 && chosenAnimal == 6
            {
                won = true
            }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return kComponetCount
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == kAnimalComponet
        {
            return animalNames.count
        }
        else
        {
            return animalSounds.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        if component == kAnimalComponet
        {
            let chosenImageView: UIImageView = animalImages[row]
            let workaroundImageView: UIImageView = UIImageView(frame: chosenImageView.frame)
            workaroundImageView.backgroundColor = UIColor(patternImage: chosenImageView.image!)
            return workaroundImageView
        }
        else
        {
            let soundLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 100, 32))
            soundLabel.backgroundColor = UIColor.clearColor()
            soundLabel.text = animalSounds[row]
            return soundLabel
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 55.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == kAnimalComponet
        {
            return 75.0
        }
        else
        {
            return 150.0
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == kAnimalComponet
        {
            chosenSound = pickerView.selectedRowInComponent(kSoundComponet)
            chosenAnimal = row
        }
        else
        {
            chosenAnimal = pickerView.selectedRowInComponent(kAnimalComponet)
            chosenSound = row
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animalNames = ["Mouse", "Goose", "Cat", "Dog", "Snake", "Bear", "Pig"]
        animalSounds = ["Oink", "Rawr","Ssss","Roof","Meow","Honk","Squeak"]
        animalImages = [
            UIImageView(image: UIImage(named: "mouse.png")),
            UIImageView(image: UIImage(named: "goose.png")),
            UIImageView(image: UIImage(named: "cat.png")),
            UIImageView(image: UIImage(named: "dog.png")),
            UIImageView(image: UIImage(named: "snake.png")),
            UIImageView(image: UIImage(named: "bear.png")),
            UIImageView(image: UIImage(named: "pig.png")),
        ]
        
        preferredContentSize = CGSizeMake(340, 380)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
