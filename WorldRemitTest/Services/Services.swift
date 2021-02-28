//
//  Services.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 28/02/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

class Services {
    let usersService: UsersProviding
    private let networkService: Networking
    let decimalFormatter: DecimalFormatter
    let imageDownloader: ImageService

    init(session: SessionProtocol = URLSession.shared) {
        if ProcessInfo.processInfo.arguments.contains("UI-TESTING") {
            let mockURL = URL(string: "https://test.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow")!
            let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
            let urlResponse = HTTPURLResponse(url: mockURL,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)
            let mockURLSession = MockURLSession(data: jsonData,
                                                urlResponse: urlResponse,
                                                error: nil)
            let sut = NetworkingService(session: mockURLSession)
            self.networkService = sut
        } else {
            self.networkService = NetworkingService(session: session)
        }
        self.usersService = UsersService(network: networkService)
        self.decimalFormatter = DecimalFormatter()
        self.imageDownloader = ImageDownloader()
    }
}
