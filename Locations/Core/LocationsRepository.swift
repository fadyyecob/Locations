//
//  LocationsRepository.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

struct LocationsRepository {
    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchLocations(_ completion: @escaping (Result<[Location], Error>) -> Void) {
        let request = URLRequest.makeAppRequst(path: "/abnamrocoesd/assignment-ios/main/locations.json")

        urlSession.dataTask(request, decode: [String: [Location]].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(.success(data["locations"] ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
