//
//  FakeUsersRepository.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 07/03/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class FakeUsersRepository: UsersRepository {
    var error: Error?

    init(error: Error? = nil) {
        self.error = error
    }

    func getUsers(completion: @escaping (Result<Users, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }

        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let users = try! decoder.decode(Users.self, from: jsonData)
        completion(.success(users))
    }
}
