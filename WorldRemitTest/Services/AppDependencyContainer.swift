//
//  AppDependencyContainer.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 28/02/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

class AppDependencyContainer {
    lazy var usersRepository: UsersRepository = {
        let usersRepository = RemoteUsersRepository(network: networkService)
        return usersRepository
    }()

    lazy var networkService: Networking = {
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
            return sut
        } else {
            let networkService = NetworkingService(session: session)
            return networkService
        }
    }()

    lazy var decimalFormatter: DecimalFormatter = DecimalFormatter()
    lazy var imageCache: ImageService = ImageDownloader()

    private let session: SessionProtocol

    init(session: SessionProtocol = URLSession.shared) {
        self.session = session
    }
}

// MARK:- UsersViewModelFactory
extension AppDependencyContainer: UsersViewModelFactory {
    func makeUsersViewModel() -> UsersViewModel {
        return UsersViewModel(usersRepository: usersRepository,
                              userViewModelFactory: self)
    }
}

// MARK:- UsersViewModelFactory
extension AppDependencyContainer: UserViewModelFactory {
    func makeUserViewModel(for user: User) -> UserViewModel {
        return UserViewModel(user: user,
                             decimalFormatter: decimalFormatter,
                             imageCache: imageCache)
    }
}
