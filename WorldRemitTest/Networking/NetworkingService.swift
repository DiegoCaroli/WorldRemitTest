//
//  NetworkingService.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

protocol UsersProviding {
    func getUsers(
        completionHandler: @escaping (Result<Users, Error>) -> Void
    )
}

class NetworkingService: UsersProviding {

    private let session: SessionProtocol
    private var dataTask: URLSessionDataTask?

    init(session: SessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getUsers(
        completionHandler: @escaping (Result<Users, Error>) -> Void
    ) {
        fetch(with: urlComponents, completionHandler: completionHandler)
    }

    private func fetch<T: Decodable>(
        with components: URLComponents,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        dataTask?.cancel()
        guard let url = components.url else { return }

        dataTask = session.dataTask(with: url) { data, response, error in

                if let error = error {
                    guard (error as NSError).code != NSURLErrorCancelled else {
                        return
                    }
                    completionHandler(.failure(error))
                    return
                }

                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    200 ..< 299 ~= response.statusCode else {
                        let error = NSError(domain: "Server error", code: 0, userInfo: nil)
                        completionHandler(.failure(error))
                        return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async { completionHandler(.success(result)) }
                } catch {
                    completionHandler(.failure(error))
                }
        }

        dataTask?.resume()
    }

}

// MARK: - Stackexchange API
private extension NetworkingService {
    struct StackexchangeAPI {
        static let scheme = "https"
        static let host = "api.stackexchange.com"
        static let path = "/2.2/users"
    }

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = StackexchangeAPI.scheme
        components.host = StackexchangeAPI.host
        components.path = StackexchangeAPI.path

        components.queryItems = [
            URLQueryItem(name: "pagesize", value: "20"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "reputation"),
            URLQueryItem(name: "site", value: "stackoverflow")
        ]

        return components
    }

}
