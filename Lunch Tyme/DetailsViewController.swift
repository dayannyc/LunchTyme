//
//  DetailsViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/11/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsViewController: UIViewController {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var categoryType: UILabel!
    @IBOutlet weak var restarauntAddr: UILabel!
    @IBOutlet weak var restaurantMap: MKMapView!
    @IBOutlet weak var phoneBttn: UIButton!
    @IBOutlet weak var twitterHandle: UIButton!
    
    var currRestaurant:Restaurant?
    var restaurantArr = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantName.text = currRestaurant?.name
        categoryType.text = currRestaurant?.category
        restarauntAddr.text = (currRestaurant?.location?.address)!+"\n"+(currRestaurant?.location?.formattedAddress![1])!
        
        // check if contact is nil and if it is hide labels, else change them accordingly
        if currRestaurant?.contact != nil {
            let contact = currRestaurant?.contact
            checkNil(bttn: phoneBttn, currStr: contact?.formattedPhone, leadingStr: "")
            checkNil(bttn: twitterHandle, currStr: contact?.twitter, leadingStr: "@")
        } else {
            phoneBttn.isHidden = true
            twitterHandle.isHidden = true
        }
        
        let location = currRestaurant?.location
        createAnnotation(currLocation: location!)
        zoomToLocation(currLocation: location!)
    }
    
    // creates annotation for the location of this restaurant
    func createAnnotation(currLocation:Location) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake((currLocation.lat)!, (currLocation.lng)!)
        restaurantMap.addAnnotation(annotation)
    }
    
    // zooms into the location of this restaurant
    func zoomToLocation(currLocation:Location) {
        let regionRadius: CLLocationDistance = 750
        let initialLocation = CLLocation(latitude: (currLocation.lat)!, longitude: (currLocation.lng)!)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  regionRadius, regionRadius)
        restaurantMap.setRegion(coordinateRegion, animated: true)
    }
    
    // update label only if information isn't nil
    func checkNil(bttn:UIButton, currStr:String?, leadingStr:String) {
        if currStr != nil {
            let fullStr = leadingStr + currStr!
            bttn.setTitle(fullStr, for: UIControlState.normal)
        } else {
            bttn.isHidden = true
        }
    }
    
    @IBAction func phoneBttnClicked(_ sender: Any) {
        let phoneStr:String = (currRestaurant?.contact?.phone)!
        let url = URL(string: "tel://\(phoneStr)")
        UIApplication.shared.open(url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // pass information of restaurants to map view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsMapSeg" {
            let seg = segue.destination as! MapViewController
            seg.restaurantArr = restaurantArr
        } else if segue.identifier == "detailsInternetSeg" {
            let seg = segue.destination as! InternetViewController
            
            // send this restaurant's twitter website to internet VC
            let url:String = (currRestaurant?.contact?.twitter)!
            let destURLStr = "http://twitter.com/\(url)"
            seg.urlStr = destURLStr
        }

    }

}
