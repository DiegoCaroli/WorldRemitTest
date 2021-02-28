//
//  SessionProtocol.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
