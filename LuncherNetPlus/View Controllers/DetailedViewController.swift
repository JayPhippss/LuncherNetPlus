//
//  DetailedViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/24/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import MapKit

class DetailedViewController: UIViewController{
    @IBOutlet weak var restNameLbl: UILabel!
    @IBOutlet weak var catNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var zipcodeLbl: UILabel!
    @IBOutlet weak var twitterLbl: UILabel!
    
    @IBOutlet weak var phoneTextView: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restName = "", catName = "", address = "", city = "", state = "", zip = "", phoneNum = "", twitter = ""
    
    var cordLat = 0.0, cordLong = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let restCords = CLLocationCoordinate2D(latitude: cordLat, longitude: cordLong)
        let restAnn = RestaurantAnnotation(coordinate: restCords, title: restName, subtitle: catName)
        mapView.addAnnotation(restAnn)
        mapView.setRegion(restAnn.region, animated: true)

        restNameLbl.text! = restName
        catNameLbl.text! = catName
        addressLbl.text! = address
        cityLbl.text! = city
        stateLbl.text! = state
        zipcodeLbl.text! = zip
        twitterLbl.text! = twitter
        phoneTextView.text! =  phoneNum
//        twitterBtn.setTitle(twitter, for: .normal)
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
