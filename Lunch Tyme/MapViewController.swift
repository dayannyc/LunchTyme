//
//  MapViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/14/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

//import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var restaurantMap: MKMapView!
    var restaurantArr = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnnotations()
        zoomToLocation(currLocation: restaurantArr[5].location!)
    }
    
    // creates annotations for the locations of all the restaurants
    func createAnnotations() {
        var restaurantAnns:[MKPointAnnotation] = []
        for currRestaurant in restaurantArr {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake((currRestaurant.location?.lat)!, (currRestaurant.location?.lng)!)
            annotation.title = currRestaurant.name
            restaurantAnns.append(annotation)
        }
        restaurantMap.addAnnotations(restaurantAnns)
    }
    
    // zooms into the location of specified restaurant
    func zoomToLocation(currLocation:Location) {
        let regionRadius: CLLocationDistance = 850
        let initialLocation = CLLocation(latitude: (currLocation.lat)!, longitude: (currLocation.lng)!)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  regionRadius, regionRadius)
        restaurantMap.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
