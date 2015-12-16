//
//  ViewController.swift
//  Cupertino
//
//  Created by csit267-8 on 11/30/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AudioToolbox

class ViewController: UIViewController, CLLocationManagerDelegate,  MKMapViewDelegate{
    
    @IBOutlet var waitView: UIView!
    @IBOutlet var distanceView: UIView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var directionArrow: UIImageView!
    
    let locMan: CLLocationManager = CLLocationManager()
    let kCupertinoLatitude: CLLocationDegrees = 28.385361
    let kCupertinoLongitude: CLLocationDegrees = -81.563889
    let kDeg2Rad:Double=0.0174532925
    let kRad2Deg:Double=57.2957795
    
    var recentLocation: CLLocation!
    
    var soundStraight: SystemSoundID = 0
    var soundRight: SystemSoundID = 0
    var soundLeft: SystemSoundID = 0
    var lastSound: SystemSoundID = 0
 

    func showAddress()
    {
        var lat:CLLocationDegrees = kCupertinoLatitude/4
        var long:CLLocationDegrees = kCupertinoLongitude/4
        
        if lat < 0 {
            lat = lat * -1
        }
        
        if long < 0 {
            long = long * -1
        }
        
        if lat > 180 {
            lat = 180
        }
        
        if long > 360 {
            long = 360
        }
        

        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(lat, long)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake((recentLocation.coordinate.latitude + kCupertinoLatitude) / 2, (recentLocation.coordinate.longitude + kCupertinoLongitude) / 2)
        
        print(recentLocation.coordinate.latitude)
        print(recentLocation.coordinate.longitude)
        print(kCupertinoLatitude)
        print(kCupertinoLongitude)
        print(pointLocation.latitude)
        print(pointLocation.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
        map.setRegion(region, animated: true)

        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocationCoordinate2DMake(kCupertinoLatitude, kCupertinoLongitude)
        objectAnnotation.title = "Disney World"
        self.map.addAnnotation(objectAnnotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinDrop:MKPinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myspot")
        pinDrop.animatesDrop=true
        pinDrop.canShowCallout=true
        pinDrop.pinTintColor=MKPinAnnotationView.purplePinColor()
        return pinDrop
    }
    
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
                if lastSound != soundStraight {
                    AudioServicesPlaySystemSound(soundStraight)
                    lastSound=soundStraight
                }
            } else {
                if (delta > 180) {
                    directionArrow.image = UIImage(named: "right_arrow.png")
                    if lastSound != soundRight {
                        AudioServicesPlaySystemSound(soundRight)
                        lastSound=soundRight
                    }
                }
                else if (delta > 0) {
                    directionArrow.image = UIImage(named: "left_arrow.png")
                    if lastSound != soundLeft {
                        AudioServicesPlaySystemSound(soundLeft)
                        lastSound=soundLeft
                    }
                }
                else if (delta > -180) {
                    directionArrow.image = UIImage(named: "right_arrow.png")
                    if lastSound != soundRight {
                        AudioServicesPlaySystemSound(soundRight)
                        lastSound=soundRight
                    }
                }
                else {
                    directionArrow.image = UIImage(named: "left_arrow.png")
                    if lastSound != soundLeft {
                        AudioServicesPlaySystemSound(soundLeft)
                        lastSound=soundLeft
                    }
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
                distanceLabel.text="Enjoy the \nDisney World!"
            }
            else
            {
                let commaDelimited:NSNumberFormatter=NSNumberFormatter()
                distanceLabel.text=commaDelimited.stringFromNumber(miles)
                distanceLabel.text=distanceLabel.text!+" miles to the \nDisney World"
            }
            waitView.hidden=true
            distanceView.hidden=false
            showAddress()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({() -> Void in
            })
        
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
        
        var soundFile:String!
        
        soundFile = NSBundle.mainBundle().pathForResource("straight", ofType: "wav")!
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: soundFile), &soundStraight)
        
        soundFile = NSBundle.mainBundle().pathForResource("right", ofType: "wav")!
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: soundFile), &soundRight)
        
        soundFile = NSBundle.mainBundle().pathForResource("left", ofType: "wav")!
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: soundFile), &soundLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

