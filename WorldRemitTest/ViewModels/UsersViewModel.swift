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
    private(set) var users: [UserViewModel]
    private let decimalFormatter: DecimalFormatter
    private let imageDownloader: ImageService
    var onUsersUpdate: (() -> ())?
    var onErrorUpdate: ((Error) -> ())?
    var numberOfUsers: Int { users.count }

    init(usersRepository: UsersRepository,
         decimalFormatter: DecimalFormatter,
         imageDownloader: ImageService) {
        self.usersRepository = usersRepository
        self.decimalFormatter = decimalFormatter
        self.imageDownloader = imageDownloader
        self.users = []
    }

    func fetchUsers() {
        usersRepository.getUsers{ [weak self] result in
            switch result {
                case .success(let users):
                    self?.users = users.items.compactMap { [weak self] user in
                        guard let self = self else { return nil }
                        return UserViewModel(user: user,
                                             decimalFormatter: self.decimalFormatter,
                                             imageDownloader: self.imageDownloader)
                    }
                    self?.onUsersUpdate?()
                case .failure(let error):
                    self?.onErrorUpdate?(error)
            }
        }
    }

}
