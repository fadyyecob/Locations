//
//  LocationListItemViewModel.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

struct LocationListItemViewModel: Hashable {
    let title: String
    let subtitle: String
    let deeplink: URL
    
    init(
        name: String?,
        longitude: Double,
        latitude: Double,
        deeplinkingFactory: WikipediaDeeplinkingFactory
    ) {
        title = name ?? "Unknown location"
        subtitle = "Longitude: \(longitude), Latitude: \(latitude)"
        deeplink = deeplinkingFactory.makeDeeplink(longitude: longitude, latitude: latitude)
    }
}
