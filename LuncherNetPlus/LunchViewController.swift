//
//  LunchViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/18/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import Firebase


class LunchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var logoutBrn: UIButton!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var catPicker: UIPickerView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var restaurantsNames = [Restaurant]()
    var restaurantCat = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

       viewLeading.constant = -175
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        collectionView.dataSource = self
        
        makeGetCall()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! LunchCollectionViewCell
        
        cell.restNameLbl.text = restaurantsNames[indexPath.row].name.capitalized
        cell.catNameLbl.text = restaurantsNames[indexPath.row].category.capitalized
        cell.lunchImgView.contentMode = .scaleAspectFill
        let urlImg = restaurantsNames[indexPath.row].backgroundImageURL
        cell.lunchImgView.downloadedFrom(url: urlImg)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
//        desVC.restN = restaurantsNames[indexPath[0]].name.capitalized
//        desVC.catN = restaurantsNames[indexPath[0]].category.capitalized
//
//        desVC.addyN = (restaurantsNames[indexPath[0]].location?.address)!
//        desVC.cityN = (restaurantsNames[indexPath[0]].location?.city)!
//        desVC.stateN = (restaurantsNames[indexPath[0]].location?.state)!
//
//        if (restaurantsNames[indexPath[0]].location?.postalCode == nil){
//            desVC.zipC = ""
//        } else {
//            desVC.zipC = (restaurantsNames[indexPath[0]].location?.postalCode)!
//        }
//
//        if (restaurantsNames[indexPath[0]].contact?.formattedPhone == nil){
//            desVC.phoneN = ""
//        } else {
//            desVC.phoneN = (restaurantsNames[indexPath[0]].contact?.formattedPhone)!
//        }
//
//        if (restaurantsNames[indexPath[0]].contact?.twitter == nil){
//            desVC.twitH = ""
//        } else {
//            let twitAt: String? = "@"
//            desVC.twitH = (twitAt! + (restaurantsNames[indexPath[0]].contact?.twitter)!)
//        }
//
//        desVC.cordLat = (restaurantsNames[indexPath[0]].location?.lat)!
//        desVC.cordLong = (restaurantsNames[indexPath[0]].location?.lng)!
//
//
//        self.navigationController?.pushViewController(desVC, animated: true)
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantCat.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurantCat[row]
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
    
    
    
    
    
    
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed{
            let tranlation = sender.translation(in: self.view).x
            
            if tranlation > 0 { //swipe right
                
                if viewLeading.constant < 20 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewLeading.constant += tranlation / 10
                        self.view.layoutIfNeeded()
                    })
                }
            } else { //swipe left
                if viewLeading.constant > -175 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewLeading.constant += tranlation / 10
                        self.view.layoutIfNeeded()
                    })
                }
            }
        } else if sender.state == .ended {
            
            if viewLeading.constant < -100 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewLeading.constant = -175
                    self.view.layoutIfNeeded()
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewLeading.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
            
        }
    }

    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        }
    
    
    //URL Session
    func makeGetCall(){
        let restaurantEndPoint: String = "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"
        guard let url = URL(string: restaurantEndPoint) else {
            print("Error: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            
            guard error == nil else {
                print("error getting restaurants")
                print(error!)
                return
            }
            
            
            do{
                
                let restaurantsData = try JSONDecoder().decode(RestaurantList.self, from: data!)
                //return the number of restaurants print(restaurantsData.restaurants.count)
                self.restaurantsNames = restaurantsData.restaurants
                self.goThroughCat()
            } catch {
                print(error)
            }
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
            
        }
        task.resume()
    }
    
    func goThroughCat (){
        for restCat in restaurantsNames {
            let currentCat = restCat.category
            if restaurantCat.contains(currentCat) == false{
                restaurantCat.append(currentCat)
            }
        }
        restaurantCat.append("All")
    }
}



