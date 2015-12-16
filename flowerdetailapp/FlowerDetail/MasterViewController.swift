//
//  MasterViewController.swift
//  FlowerDetail
//
//  Created by csit267-8 on 11/6/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()

    var flowerData: [AnyObject] = []
    var flowersections: [String] = []
    
    func createFlowerData()
    {
        var redFlowers: [Dictionary<String,String>] = []
        var blueFlower: [Dictionary<String,String>] = []
        
        flowersections = ["Red Flowers", "Blue Flowers"]
        
        redFlowers.append(["name":"Poppy","picture":"Poppy.png","url":"https://en.wikipedia.org/wiki/Poppy"])
        redFlowers.append(["name":"Straw Flower","picture":"Strawflower.png","url":"https://en.wikipedia.org/wiki/Peony"])
        blueFlower.append(["name":"Hyacinth","picture":"Hyacinth.png","url":"https://en.wikipedia.org/wiki/Hyacinth_(flower)"])
        blueFlower.append(["name":"Iris","picture":"Iris.png","url":"https://en.wikipedia.org/wiki/Iris_(plant)"])
        
        flowerData = [redFlowers,blueFlower]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
        
        createFlowerData()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = self.flowerData[indexPath.section][indexPath.row]
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return flowersections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerData[section].count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return flowersections[section]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flowerCell", forIndexPath: indexPath) as! MyCustomTableViewCell

        let url = flowerData[indexPath.section][indexPath.row]["url"] as? String
        cell.titleLabel!.text=flowerData[indexPath.section][indexPath.row]["name"] as? String
        cell.descriptionLabel!.text="  \(url)"
        cell.picture!.image=UIImage(named: flowerData[indexPath.section][indexPath.row]["picture"] as! String)
        
        cell.rowLabel!.text="Row: \(indexPath.row+1)"

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

