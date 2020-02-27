//
//  MockURLSession.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

class MockURLSession: SessionProtocol {
    private var url: URL?
    private let dataTask: MockTask
    
    var urlComponents: URLComponents? {
        guard let url = url else { return nil }
        return URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
    
    init(data: Data?,
         urlResponse: URLResponse?,
         error: Error?) {
        dataTask = MockTask(data: data,
                            urlResponse: urlResponse,
                            error: error)
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        self.url = url
        dataTask.completionHandler = completionHandler
        return dataTask
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let responseError: Error?
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    
    init(
        data: Data?,
        urlResponse: URLResponse?,
        error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = error
    }
    
    override func resume() {
        DispatchQueue.main.async { [weak self] in
            self?.completionHandler?(self?.data,
                                     self?.urlResponse,
                                     self?.responseError)
        }
    }
    
}
