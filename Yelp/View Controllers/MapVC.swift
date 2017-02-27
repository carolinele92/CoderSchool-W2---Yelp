//
//  MapVC.swift
//  Yelp
//
//  Created by Caroline Le on 2/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let annotation: MKAnnotation? = nil
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set starting center location in San Francisco
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        
        
        // add all businesses' annotations on map
        for business in businesses {
            addAnnotation(name: business.name!, category: business.categories!, latitude: business.latitude!, longitude: business.longitude!)
            
            print(business.name!)
            print(business.longitude!)
            print(business.latitude!)
        }
    
        
    }
    
    // go to the user's location when permission has been given
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    
    // add map annitation
    func addAnnotation (name: String, category: String, latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.subtitle = category
        annotation.coordinate.latitude = latitude
        annotation.coordinate.longitude = longitude
        mapView.addAnnotation(annotation)
    }
    

}
