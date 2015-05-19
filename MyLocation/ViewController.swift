//
//  ViewController.swift
//  MyLocation
//
//  Created by Charles Konkol on 1/29/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManagers = CLLocationManager()
  
    @IBOutlet weak var longitude: UILabel!
    
    @IBAction func btnStops(sender: UIButton) {
        if IsMap==true{
            IsMap=false
            btnStop.setTitle("Start", forState: UIControlState.Normal) 
        }else{
            IsMap=true
           btnStop.setTitle("Stop", forState: UIControlState.Normal)
        }
    }
    @IBOutlet weak var btnStop: UIButton!
    
    var longe:Double=0.0
    var late:Double=0.0
    var IsMap=true
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var maps: MKMapView!
    
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var alt: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      self.locationManagers.requestAlwaysAuthorization()
        
      self.locationManagers.requestWhenInUseAuthorization()
    
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManagers.delegate = self
            locationManagers.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManagers.startUpdatingLocation()
        }        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        var location:CLLocation = locations[locations.count - 1] as! CLLocation
        var alts = manager.location.altitude
        
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        longitude.text = "\(locValue.longitude)"
        latitude.text = "\(locValue.latitude)"
        longe = (locValue.longitude)
        late = (locValue.latitude)
         alt.text = "\(alts)"
         speed.text = "\(location.speed)"
        
        if IsMap==true{
            self.getlocations()
        }
        
        
    }
    
    func getlocations(){
        
        var location = CLLocationCoordinate2D(
            latitude: late,
            longitude: longe
        )
        var span = MKCoordinateSpanMake(0, 0)
        var region = MKCoordinateRegion(center: location, span: span)
        maps.setRegion(region, animated: true)
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Location"
        annotation.subtitle = location.longitude.description + "," + location.latitude.description
        maps.addAnnotation(annotation)
        
    }
    
}

