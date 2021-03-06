//
//  ViewController.swift
//  BestFriend
//
//  Created by csit267-8 on 11/29/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
import MapKit
import CoreLocation
import MessageUI
import Social

class ViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var map: MKMapView!
    
    let locMan: CLLocationManager = CLLocationManager()
    
    @IBAction func newBFF(sender: AnyObject) {
        let picker: ABPeoplePickerNavigationController = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        let friendName: String = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as! String as String
        name.text = friendName
        print("\(friendName)")
        

        let friendAddressSet: ABMultiValueRef = try ABRecordCopyValue(person, kABPersonAddressProperty).takeRetainedValue()

        
        if ABMultiValueGetCount(friendAddressSet)>0
        {
            let friendFristAddress: NSDictionary = ABMultiValueCopyValueAtIndex(friendAddressSet, 0).takeRetainedValue() as! NSDictionary
            // do something useful here
            showAddress(friendFristAddress)
        }
        
        let friendEmailAddress: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
        
        if ABMultiValueGetCount(friendEmailAddress)>0
        {
            let friendEmail: String = ABMultiValueCopyValueAtIndex(friendEmailAddress, 0).takeRetainedValue() as! String
            email.text=friendEmail
        }
        
        if ABPersonHasImageData(person)
        {
            photo.image = UIImage(data: ABPersonCopyImageData(person).takeRetainedValue())
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinDrop:MKPinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myspot")
        pinDrop.animatesDrop=true
        pinDrop.canShowCallout=true
        pinDrop.pinColor=MKPinAnnotationColor.Purple
        return pinDrop
    }
    
    @IBAction func sendEmail(sender: AnyObject) {
        let emailAddress:[String]=[email.text!]
        let mailComposer:MFMailComposeViewController = MFMailComposeViewController()
        mailComposer.mailComposeDelegate=self
        mailComposer.setToRecipients(emailAddress)
        presentViewController(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        let geoCoder: CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(map.userLocation.location!, completionHandler: {(placemarks, error) -> Void in
            let myPlacemark = placemarks?[0]
            let tweetText:String = "Hello all = I'm currently in \(myPlacemark?.locality)!"
            
            let tweetComposer: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
            {
                tweetComposer.setInitialText(tweetText)
                self.presentViewController(tweetComposer, animated: true, completion: nil)
            }
        })
    }
    
    func showAddress(fullAddress:NSDictionary)
    {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressDictionary(fullAddress as [NSObject : AnyObject], completionHandler: {(placemarks, error) -> Void in
                let friendPlacemark = placemarks?[0]
                let mapRegion:MKCoordinateRegion =
                MKCoordinateRegion(center: friendPlacemark!.location!.coordinate,
                    span: MKCoordinateSpanMake(0.2, 0.2))
                self.map.setRegion(mapRegion, animated: true)
                let mapPlacemark: MKPlacemark = MKPlacemark(placemark: friendPlacemark!)
                self.map.addAnnotation(mapPlacemark)
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func promptForAddressBookRequestAccess() {
        let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()

        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    print("Just denied")
                } else {
                    print("Just authorized")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locMan.requestWhenInUseAuthorization()
        locMan.requestAlwaysAuthorization()
        promptForAddressBookRequestAccess()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

