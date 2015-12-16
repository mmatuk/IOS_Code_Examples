//
//  ViewController.swift
//  FlowerColorTable
//
//  Created by csit267-8 on 11/4/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var kSectionCount: Int!
    
    var sectionNames: [String]!
    var data: [AnyObject]!

    func createData()
    {
        var redFlowers: [Dictionary<String,String>] = []
        var blueFlowers: [Dictionary<String,String>] = []
        
        sectionNames = ["Red Flowers", "Blue Flowers"]
        
        redFlowers.append(["name":"Gerbera","picture":"Gerbera.png"])
        redFlowers.append(["name":"Peony","picture":"Peony.png"])
        redFlowers.append(["name":"Rose","picture":"Rose.png"])
        redFlowers.append(["name":"Poppy","picture":"Poppy.png"])
        redFlowers.append(["name":"Hollyhock","picture":"Hollyhock.png"])
        redFlowers.append(["name":"Strawflower","picture":"Strawflower.png"])


        blueFlowers.append(["name":"Hyacinth","picture":"Hyacinth.png"])
        blueFlowers.append(["name":"Hydrangea","picture":"Hydrangea.png"])
        blueFlowers.append(["name":"Sea Holly","picture":"Sea Holly.png"])
        blueFlowers.append(["name":"Phlox","picture":"Phlox.png"])
        blueFlowers.append(["name":"Iris","picture":"Iris.png"])
        blueFlowers.append(["name":"Grape Hyacinth","picture":"Grape Hyacinth.png"])
        blueFlowers.append(["name":"Pincushion","picture":"Pincushion flower.png"])

        data = [redFlowers,blueFlowers]
        
        kSectionCount = data.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("flowerCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = data[indexPath.section][indexPath.row]["name"] as? String
        
        let flowerImage: UIImage = UIImage(named: (data[indexPath.section][indexPath.row]["picture"] as? String)!)!
        cell.imageView!.image=flowerImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var flowerMessage: String
        let name = data[indexPath.section][indexPath.row]["name"] as! String
        flowerMessage = "You chose the \"\(sectionNames[indexPath.section])\" named: \"\(name)\""
        
        let alertController = UIAlertController(title: "Flower Selected", message: flowerMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

