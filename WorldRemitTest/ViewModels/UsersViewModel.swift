//
//  UsersViewModel.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

class UsersViewModel {

    private let usersRepository: UsersRepository
    private let userViewModelFactory: UserViewModelFactory

    private(set) var users: [UserViewModel]
    var onUsersUpdate: (() -> ())?
    var onErrorUpdate: ((Error) -> ())?
    var numberOfUsers: Int { users.count }

    init(usersRepository: UsersRepository,
         userViewModelFactory: UserViewModelFactory) {
        self.usersRepository = usersRepository
        self.userViewModelFactory = userViewModelFactory
        self.users = []
    }

    func fetchUsers() {
        usersRepository.getUsers{ [weak self] result in
            switch result {
                case .success(let users):
                    self?.users = users.items.compactMap { [weak self] in
                        self?.userViewModelFactory.makeUserViewModel(for: $0)
                    }
                    self?.onUsersUpdate?()
                case .failure(let error):
                    self?.onErrorUpdate?(error)
            }
        }
    }

}
