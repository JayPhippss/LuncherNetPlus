//
//  JSONHandler.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/22/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import Foundation


////URL Session
//func makeGetCall(){
//    let restaurantEndPoint: String = "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"
//    guard let url = URL(string: restaurantEndPoint) else {
//        print("Error: Cannot create URL")
//        return
//    }
//    
//    let urlRequest = URLRequest(url: url)
//    
//    let config = URLSessionConfiguration.default
//    let session = URLSession(configuration: config)
//    
//    let task = session.dataTask(with: urlRequest){
//        (data, response, error) in
//        
//        guard error == nil else {
//            print("error getting restaurants")
//            print(error!)
//            return
//        }
//        
//        
//        do{
//            
//            let restaurantsData = try JSONDecoder().decode(RestaurantList.self, from: data!)
//            //return the number of restaurants print(restaurantsData.restaurants.count)
//            restaurantsNames = restaurantsData.restaurants
//            print(restaurantsData.restaurants.count)
//        } catch {
//            print(error)
//        }
//        DispatchQueue.main.sync {
//            collectionView.reloadData()
//        }
//        
//    }
//    task.resume()
//}
