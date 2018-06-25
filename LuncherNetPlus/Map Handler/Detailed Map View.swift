//
//  Detailed Map View.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/25/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import Foundation
import UIKit
import MapKit


extension UIViewController: MKMapViewDelegate{
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let restAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            restAnnotation.animatesWhenAdded = true
            restAnnotation.titleVisibility = .adaptive
            restAnnotation.titleVisibility = .adaptive
            
            return restAnnotation
        }
        
        return nil
    }
}


final class RestaurantAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpanMake(0.005, 0.005)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
    
    var region1: MKCoordinateRegion{
        let span = MKCoordinateSpanMake(0.08, 0.08)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}
