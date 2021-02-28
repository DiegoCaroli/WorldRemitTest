//
//  Endpoint.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 28/02/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

enum Endpoint {
    case users
}

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

extension Endpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
            case .users:
                guard let url = urlComponents.url else {
                    preconditionFailure("Invalid URL used to create URL instance")
                }

                return URLRequest(url: url)
        }
    }
}

// MARK:- Stackexchange API
private extension Endpoint {
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
