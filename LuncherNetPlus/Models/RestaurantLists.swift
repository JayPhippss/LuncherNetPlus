//
//  RestaurantLists.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/22/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import Foundation

struct RestaurantList: Decodable {
    let restaurants: [Restaurant]
    
}

struct Restaurant: Decodable {
    let name: String
    let backgroundImageURL: URL
    let category: String
    let contact: Contact?
    let location: Location?
    
}

struct Contact: Decodable {
    let phone : String?
    let formattedPhone: String?
    let twitter: String?
    //add facebook if needed
}

struct Location: Decodable{
    let address: String
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddresses: [FormattedAddress]?
}

struct FormattedAddress: Decodable {
    let formattedAddress: String?
}
