//
//  ViewController.swift
//  Cupertino
//
//  Created by csit267-8 on 11/30/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var waitView: UIView!
    @IBOutlet var distanceView: UIView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var directionArrow: UIImageView!
    
    let locMan: CLLocationManager = CLLocationManager()
    let kCupertinoLatitude: CLLocationDegrees = 37.3229978
    let kCupertinoLongitude: CLLocationDegrees = -122.0321823
    let kDeg2Rad:Double=0.0174532925
    let kRad2Deg:Double=57.2957795
    
    var recentLocation: CLLocation!

    func headingToLocation(desired: CLLocationCoordinate2D, current: CLLocationCoordinate2D) -> Double
    {
        // Gather the variables needed by the heading algorithm
        let lat1:Double = current.latitude*kDeg2Rad
        let lat2: Double = desired.latitude*kDeg2Rad
        let lon1: Double  = current.longitude
        let lon2: Double = desired.longitude
        let dlon: Double = (lon2-lon1)*kDeg2Rad
        
        let y: Double = sin(dlon)*cos(lat2)
        let x: Double = cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(dlon)
        
        var heading:Double = atan2(y,x)
        heading=heading*kRad2Deg
        heading=heading+360.0
        heading=fmod(heading,360.0)
        return heading
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        if (recentLocation != nil && newHeading.headingAccuracy >= 0) {
            let cupertino:CLLocation = CLLocation(latitude: kCupertinoLatitude,longitude: kCupertinoLongitude)
            let course: Double = headingToLocation(cupertino.coordinate, current:recentLocation.coordinate)
            let delta: Double = newHeading.trueHeading - course
            if (abs(delta) <= 10) {
                directionArrow.image = UIImage(named: "up_arrow.png")
            } else {
                if (delta > 180) {
                    directionArrow.image = UIImage(named: "right_arrow.png")
                }
                else if (delta > 0) {
                    directionArrow.image = UIImage(named: "left_arrow.png")
                }
                else if (delta > -180) {
                    directionArrow.image = UIImage(named: "right_arrow.png")
                }
                else {
                    directionArrow.image = UIImage(named: "left_arrow.png")
                }
            }
            directionArrow.hidden = false
        } else {
            directionArrow.hidden = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.Denied.rawValue
        {
            locMan.stopUpdatingLocation()
            print("denied")
        }
        else
        {
            waitView.hidden=true
            distanceView.hidden=false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: CLLocation = locations[0]
        if newLocation.horizontalAccuracy >= 0
        {
            //store the location for use during heading
            recentLocation=newLocation
            let Cupertino:CLLocation=CLLocation(latitude: kCupertinoLatitude, longitude: kCupertinoLongitude)
            let delta:CLLocationDistance=Cupertino.distanceFromLocation(newLocation)
            let miles:Double=(delta * 0.000621371) // meters to rounded miles
            if miles < 3
            {
                //stop updating the location
                locMan.stopUpdatingLocation()
                locMan.stopUpdatingHeading()
                //congradulate the user
                distanceLabel.text="Enjoy the \nMothership!"
            }
            else
            {
                let commaDelimited:NSNumberFormatter=NSNumberFormatter()
                distanceLabel.text=commaDelimited.stringFromNumber(miles)
                distanceLabel.text=distanceLabel.text!+" miles to the \nMothership"
            }
            waitView.hidden=true
            distanceView.hidden=false
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locMan.delegate=self
        locMan.desiredAccuracy=kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter=1609; // a mile
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        
        if CLLocationManager.headingAvailable()
        {
            locMan.headingFilter = 10 // 10 degrees
            locMan.startUpdatingHeading()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

