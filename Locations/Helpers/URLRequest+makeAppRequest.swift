//
//  URLRequest+makeAppRequest.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

extension URLRequest {
    static func makeAppRequst(path: String, httpMethod: HTTPMethod = .get) -> Self {
        let urlComponents = URLComponents.makeAppBaseURL(path: path)
        
        var urlRequest = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}
