//
//  UsersViewModelTests.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class UsersViewModelTests: XCTestCase {

    var sut: UsersViewModel!
    var usersRepository: FakeUsersRepository!
    var userViewModelFactory: FakeUserViewModelFactory!

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {
        sut = nil
        usersRepository = nil
        userViewModelFactory = nil

        super.tearDown()
    }

    func testFetchUsers() {
        usersRepository = FakeUsersRepository()
        userViewModelFactory = FakeUserViewModelFactory()

        sut = UsersViewModel(usersRepository: usersRepository,
                             userViewModelFactory: userViewModelFactory)
        
        let usersExpectation = expectation(description: "Users Not Empty")

        sut.onUsersUpdate = { [unowned self] in
            XCTAssertGreaterThan(self.sut.numberOfUsers, 0)
            usersExpectation.fulfill()
        }
        sut.fetchUsers()

        wait(for: [usersExpectation], timeout: 1)
    }

    func testFetchErrorUsers() {
        let error = NSError(domain: "SomeError",
                            code: 1234,
                            userInfo: nil)

        usersRepository = FakeUsersRepository(error: error)
        userViewModelFactory = FakeUserViewModelFactory()

        sut = UsersViewModel(usersRepository: usersRepository,
                             userViewModelFactory: userViewModelFactory)

        let errorExpectation = expectation(description: "Error")

        sut.onErrorUpdate = { error in
            XCTAssertNotNil(error)
            errorExpectation.fulfill()
        }
        sut.fetchUsers()

        wait(for: [errorExpectation], timeout: 1)
    }

}
