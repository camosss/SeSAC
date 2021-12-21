//
//  Beer.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import Foundation

// imageURL, name, tagline, description, [foodPairing], brewersTips

struct Beer: Codable {
    let name, tagline, description, imageURL, brewersTips: String
    let foodPairing: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, tagline, description
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}
