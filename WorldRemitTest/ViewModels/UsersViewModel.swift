//
//  UsersViewModel.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

class UsersViewModel {

    private let networkService: NetworkingService

    init(networkService: NetworkingService) {
        self.networkService = networkService
        fetchUsers()
    }

    private func fetchUsers() {
        networkService.getUsers{ [weak self] result in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error)
            }
        }
    }

}
