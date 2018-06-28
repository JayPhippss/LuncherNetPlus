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
    @IBOutlet weak var catPicketBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var restaurantsNames = [Restaurant]()
    var restaurantCat = [String]()
    var filterArray = [Restaurant]()
    
    var currentPick = ""
    
    var menuShowing = false
    

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
    
    //Gets number of cell based on array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    //loads all data into collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! LunchCollectionViewCell
        
                let urlImg = filterArray[indexPath.row].backgroundImageURL
                cell.lunchImgView.downloadedFrom(urlString: urlImg)
                cell.restNameLbl.text = filterArray[indexPath.row].name.capitalized
                cell.catNameLbl.text = filterArray[indexPath.row].category.capitalized
                cell.lunchImgView.contentMode = .scaleAspectFill

        
        return cell
    }
    
    //Sending data to detail view on cell click
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        
        
        desVC.restName = filterArray[indexPath.row].name.capitalized
        desVC.catName = filterArray[indexPath.row].category.capitalized
        
        desVC.address = (filterArray[indexPath.row].location?.address)!
        desVC.city = (filterArray[indexPath.row].location?.city)!
        desVC.state = (filterArray[indexPath.row].location?.state)!
        
        if (filterArray[indexPath.row].location?.postalCode == nil){
            desVC.zip = ""
        } else {
            desVC.zip = (filterArray[indexPath.row].location?.postalCode)!
        }
        
        if (filterArray[indexPath.row].contact?.formattedPhone == nil){
            desVC.phoneNum = ""
        } else {
            desVC.phoneNum = (filterArray[indexPath.row].contact?.formattedPhone)!
        }
        
        if (filterArray[indexPath.row].contact?.twitter == nil){
            desVC.twitter = ""
        } else {
            let twitAt: String? = "@"
            desVC.twitter = (twitAt! + (filterArray[indexPath.row].contact?.twitter)!)
            desVC.twitterWithOut = (filterArray[indexPath.row].contact?.twitter)!
        }
        
        desVC.cordLat = (filterArray[indexPath.row].location?.lat)!
        desVC.cordLong = (filterArray[indexPath.row].location?.lng)!
        
        
        self.navigationController?.pushViewController(desVC, animated: true)

    }
    
    //Only 1 picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //Gets the correct number of categories
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantCat.count
    }

    //Loads the catergory names in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurantCat[row]
    }
    
    //Getting catergory from picketview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPick = restaurantCat[row]
    }
    
    
    //Side menu swipe function
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        self.sideView.backgroundColor = UIColor.clear
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
    
    //Large map segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapViewController{
            let vc = segue.destination as? MapViewController
            vc?.restaurantLocations = restaurantsNames
        }
    }
    
    //Logout function
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
                self.filterArray = restaurantsData.restaurants
            } catch {
                print(error)
            }
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
                self.goThroughCat()
            }
            
        }
        task.resume()
    }
    
    //Getting Category for picker
    func goThroughCat (){
        for restCat in restaurantsNames {
            let currentCat = restCat.category
            if restaurantCat.contains(currentCat) == false{
                restaurantCat.append(currentCat)
            }
        }
        restaurantCat.insert("All", at: 0)
        restaurantCat.insert("", at: 0)
    }
    
    //Getting all restaurants based on picker view selection
    func goThroughFilter (_: String){
        for restFilter in restaurantsNames {
            let currentP = restFilter.category
            if currentPick == currentP {
                filterArray.append(restFilter)
            } else {
                if currentPick == "All"{
                    filterArray = restaurantsNames
                }
            }
        }
    }
    
    //Side menu button pressed
    @IBAction func profileClicked(_ sender: Any) {
        if (menuShowing) {
            viewLeading.constant = -175
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
           viewLeading.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    //When user presses catergory button
    @IBAction func catPicked(_ sender: Any) {
        filterArray = [Restaurant]()
        goThroughFilter(currentPick)
        collectionView.reloadData()
    }
}



