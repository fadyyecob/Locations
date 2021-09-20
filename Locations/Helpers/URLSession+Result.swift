//
//  URLSession+Result.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask<T: Decodable>(
        _ request: URLRequest,
        decode decodable: T.Type,
        decoder: JSONDecoder,
        result: @escaping (Result<T, Error>) -> Void
    )
}

extension URLSessionProtocol {
    func dataTask<T: Decodable>(
        _ request: URLRequest,
        decode decodable: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        result: @escaping (Result<T, Error>) -> Void
    ) {
        dataTask(request, decode: decodable, decoder: decoder, result: result)
    }
}

// NOTE: copied from https://getswifty.dev/typesafe-networking-with-urlsession-and-codable/ with slight modifications
extension URLSession: URLSessionProtocol {
    func dataTask<T: Decodable>(
        _ request: URLRequest,
        decode decodable: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        result: @escaping (Result<T, Error>) -> Void
    ) {
        dataTask(with: request) { data, response, error in
            guard let data = data else {
                return result(.failure(UnknownError()))
            }
            
            do {
                let object = try decoder.decode(decodable, from: data)
                DispatchQueue.main.async {
                    result(.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    result(.failure(error))
                }
            }
        }.resume()
    }

}

private struct UnknownError: Error {}
