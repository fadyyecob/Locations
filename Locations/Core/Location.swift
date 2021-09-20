//
//  Location.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

struct Location: Decodable {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}
