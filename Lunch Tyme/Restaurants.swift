//
//  Restaurants.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/13/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import Foundation

struct Location : Decodable {
    let formattedAddress : [String]?
    let lat : Double?
    let lng : Double?
    let address: String?
}

struct Contact: Decodable {
    let phone: String?
    let formattedPhone : String?
    let twitter : String?
}

struct Restaurant: Decodable {
    let name : String?
    let category : String?
    let backgroundImageURL : String?
    let contact : Contact?
    let location : Location?
}

struct AllRestaurants: Decodable{
    let restaurants : [Restaurant]
}
