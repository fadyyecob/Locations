//
//  WikipediaDeeplinkingFactory.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

struct WikipediaDeeplinkingFactory {
    func makeDeeplink(longitude: Double, latitude: Double) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "wikipedia"
        urlComponents.host = "places"
        urlComponents.queryItems = [
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "latitude", value: "\(latitude)")
        ]
        
        return urlComponents.url ?? URL(fileURLWithPath: "")
    }
}
