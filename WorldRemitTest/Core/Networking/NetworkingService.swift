//
//  NetworkingService.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

protocol Networking {
    func execute<T: Decodable>(_ requestProvider: RequestProviding,
                               completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkingService: Networking {

    private let session: SessionProtocol
    private var dataTask: URLSessionDataTask?

    init(session: SessionProtocol) {
        self.session = session
    }

    func execute<T: Decodable>(_ requestProvider: RequestProviding,
                               completion: @escaping (Result<T, Error>) -> Void) {
        dataTask?.cancel()
        let urlRequest = requestProvider.urlRequest

        dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                guard (error as NSError).code != NSURLErrorCancelled else {
                    return
                }
                completion(.failure(error))
                return
            }

            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200 ..< 299 ~= response.statusCode else {
                let error = NSError(domain: "Server error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(result)) }
            } catch {
                completion(.failure(error))
            }
        }

        dataTask?.resume()
    }

}
