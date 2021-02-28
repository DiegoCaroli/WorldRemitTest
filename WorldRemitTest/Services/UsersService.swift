//
//  UsersService.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 28/02/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

protocol UsersProviding {
    func getUsers(completion: @escaping (Result<Users, Error>) -> Void)
}

class UsersService: UsersProviding {
    private let network: Networking

    init(network: Networking) {
        self.network = network
    }

    func getUsers(completion: @escaping (Result<Users, Error>) -> Void) {
        network.execute(Endpoint.users, completion: completion)
    }
}
