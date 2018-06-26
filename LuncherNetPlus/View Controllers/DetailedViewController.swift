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
    
    @IBOutlet weak var phoneTextView: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var twitterBtn: UIButton!
    
    
    var restName = "", catName = "", address = "", city = "", state = "", zip = "", phoneNum = "", twitter = "", twitterWithOut = ""
    
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
        phoneTextView.text! =  phoneNum
        twitterBtn.setTitle(twitter, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twitterClicked(_ sender: Any) {

        let twUrl = URL(string: "twitter://user?screen_name=\(twitterWithOut)")
        let twUrlWeb = URL(string: "https://www.twitter.com/\(twitterWithOut)")!
        if UIApplication.shared.canOpenURL(twUrl!){
            UIApplication.shared.open(twUrl!, options: [:],completionHandler: nil)
        }else{
            UIApplication.shared.open(twUrlWeb, options: [:], completionHandler: nil)
        }
    }
    
    
}
