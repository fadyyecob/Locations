//
//  LocationsListViewModel.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

class LocationsListViewModel {
    private let locationsRepository: LocationsRepository
    private(set) var cachedLocations = [LocationListItemViewModel]()
    private let deeplinkingFactory: WikipediaDeeplinkingFactory
    
    init(
        locationsRepository: LocationsRepository = LocationsRepository(),
        deeplinkingFactory: WikipediaDeeplinkingFactory = WikipediaDeeplinkingFactory()
    ) {
        self.locationsRepository = locationsRepository
        self.deeplinkingFactory = deeplinkingFactory
    }
    
    func fetchLocations(_ completion: @escaping (Result<[LocationListItemViewModel], Error>) -> Void) {
        locationsRepository.fetchLocations { [weak self] result in
            switch result {
            case .success(let locations):
                let listItemViewModels = locations.compactMap { location -> LocationListItemViewModel? in
                    guard let self = self else {
                        return nil
                    }
                    
                    return LocationListItemViewModel(
                        name: location.name,
                        longitude: location.longitude,
                        latitude: location.latitude,
                        deeplinkingFactory: self.deeplinkingFactory
                    )
                }
                
                self?.cachedLocations = listItemViewModels
                
                completion(.success(listItemViewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func makeDeeplink(longitude: Double, latitude: Double) -> URL {
        deeplinkingFactory.makeDeeplink(longitude: longitude, latitude: latitude)
    }
}
