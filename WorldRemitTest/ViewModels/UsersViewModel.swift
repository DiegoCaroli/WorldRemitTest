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
    private(set) var users: [UserViewModel]
    private lazy var decimalFormatter = DecimalFormatter()
    var onUsersUpdate: (() -> ())?
    var onErrorUpdate: ((Error) -> ())?

    init(networkService: NetworkingService) {
        self.networkService = networkService
        self.users = []
    }

    func fetchUsers() {
        networkService.getUsers{ [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users.items.map { UserViewModel(user: $0, decimalFormatter: self!.decimalFormatter)}
                 self?.onUsersUpdate?()
            case .failure(let error):
                self?.onErrorUpdate?(error)
            }
        }
    }

}
