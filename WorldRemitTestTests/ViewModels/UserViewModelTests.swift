//
//  UserViewModelTests.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class UserViewModelTests: XCTestCase {

    var sut: UserViewModel!
    var mockDecimalFormatter: DecimalFormatter!
    var mockImageCache: ImageDownloader!

    override func setUp() {
        super.setUp()
        mockDecimalFormatter = DecimalFormatter()
        mockImageCache = ImageDownloader()
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let users = try! decoder.decode(Users.self, from: jsonData)
        sut = UserViewModel(user: users.items[0], decimalFormatter: mockDecimalFormatter, imageCache: mockImageCache)
    }

    override func tearDown() {
        mockDecimalFormatter = nil
        mockImageCache = nil
        sut = nil

        super.tearDown()
    }

    func testName() {
        XCTAssertEqual(sut.name, "Jon Skeet")
    }

    func testReputation() {
        XCTAssertEqual(sut.reputation, "1,166,000")
    }

    func testImage() {
         XCTAssertEqual(sut.imageURL,
                        URL(string: "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG"))
     }

    func testIsBlocked() {
        XCTAssertFalse(sut.isBlocked)
        sut.isBlocked = true
        XCTAssertTrue(sut.isBlocked)
    }

    func testIsFollowed() {
        XCTAssertFalse(sut.isFollowed)
        sut.isFollowed = true
        XCTAssertTrue(sut.isFollowed)
    }
}
