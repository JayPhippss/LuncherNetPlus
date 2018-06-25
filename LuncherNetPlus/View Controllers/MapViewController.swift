//
//  MapViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/22/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurantLocations = [Restaurant]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        for restLoc in restaurantLocations{
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let restCords = CLLocationCoordinate2D(latitude: (restLoc.location?.lat)!  , longitude: (restLoc.location?.lng)!)
        let restAnn = RestaurantAnnotation(coordinate: restCords, title: restLoc.name.capitalized, subtitle: restLoc.category.capitalized)
        mapView.addAnnotation(restAnn)
        mapView.setRegion(restAnn.region1, animated: true)
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
