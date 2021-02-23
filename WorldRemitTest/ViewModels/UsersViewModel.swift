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
    private var users: [User]
    private lazy var decimalFormatter = DecimalFormatter()
    private lazy var imageDownloader = ImageDownloader()
    var onUsersUpdate: (() -> ())?
    var onErrorUpdate: ((Error) -> ())?
    var numberOfUsers: Int { users.count }

    init(networkService: NetworkingService) {
        self.networkService = networkService
        self.users = []
    }

    func fetchUsers() {
        networkService.getUsers{ [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users.items
                self?.onUsersUpdate?()
            case .failure(let error):
                self?.onErrorUpdate?(error)
            }
        }
    }

    func userViewModel(at index: Int) -> UserViewModel {
        UserViewModel(user: users[index],
                      decimalFormatter: decimalFormatter,
                      imageDownloader: imageDownloader)
    }

}
