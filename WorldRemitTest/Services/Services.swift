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

    init() {
        self.networkService = NetworkingService()
        self.usersService = UsersService(network: networkService)
        self.decimalFormatter = DecimalFormatter()
        self.imageDownloader = ImageDownloader()
    }
}
