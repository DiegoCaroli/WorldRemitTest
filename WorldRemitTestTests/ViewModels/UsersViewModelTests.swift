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
    var mockURLSession: MockURLSession!
    var mockServices: Services!

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        mockServices = nil

        super.tearDown()
    }

    func setupSutWithJsonValidAndFetch() {
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let urlResponse = HTTPURLResponse(url: URL(string: "https://test.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow")!,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: urlResponse,
                                        error: nil)
        mockServices = Services(session: mockURLSession)
        sut = UsersViewModel(usersService: mockServices.usersService,
                             decimalFormatter: mockServices.decimalFormatter,
                             imageDownloader: mockServices.imageCache)
    }

    func setupSutWithErrorAndFetch() {
        let response = HTTPURLResponse(url: URL(string: "https://test.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow")!,
                                       statusCode: 500,
                                       httpVersion: nil,
                                       headerFields: nil)
        let error = NSError(domain: "SomeError",
                            code: 1234,
                            userInfo: nil)
        mockURLSession = MockURLSession(data: Data(),
                                        urlResponse: response,
                                        error: error)
        mockServices = Services(session: mockURLSession)
        sut = UsersViewModel(usersService: mockServices.usersService,
                             decimalFormatter: mockServices.decimalFormatter,
                             imageDownloader: mockServices.imageCache)
    }

    func testFetchUsers() {
        setupSutWithJsonValidAndFetch()
        let usersExpectation = expectation(description: "Users Not Empty")

        sut.fetchUsers()
        sut.onUsersUpdate = { [unowned self]  in
            XCTAssertGreaterThan(self.sut.numberOfUsers, 0)
            usersExpectation.fulfill()
        }

        wait(for: [usersExpectation], timeout: 1)
    }

    func testFetchErrorUsers() {
        setupSutWithErrorAndFetch()
        let errorExpectation = expectation(description: "Error")

        sut.fetchUsers()
        sut.onErrorUpdate = {error in
            XCTAssertNotNil(error)
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 1)
    }

    func testUser() {
        setupSutWithJsonValidAndFetch()
        let usersExpectation = expectation(description: "Users Not Empty")

        sut.fetchUsers()
        sut.onUsersUpdate = { [unowned self] in
            XCTAssertGreaterThan(self.sut.numberOfUsers, 0)
            usersExpectation.fulfill()
        }

        wait(for: [usersExpectation], timeout: 1)
    }

}
