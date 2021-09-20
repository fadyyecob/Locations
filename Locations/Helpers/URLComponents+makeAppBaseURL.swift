//
//  URLComponents+makeAppBaseURL.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

extension URLComponents {
    static func makeAppBaseURL(
        scheme: String = "https",
        host: String = "raw.githubusercontent.com",
        path: String
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        
        return urlComponents
    }
}
