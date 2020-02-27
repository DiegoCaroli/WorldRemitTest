//
//  UsersViewControllerTests.swift
//  WorldRemitTestUITests
//
//  Created by Diego Caroli on 27/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest

class UsersViewControllerTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil

        super.tearDown()
    }

    func testUsersView() {
        app.launch()
        XCTAssertTrue(app.isUsersView)
    }

    func testUsersTable() {
        app.launch()
        XCTAssertGreaterThan(XCUIApplication().tables.cells.count, 0)
    }

    func testBlockCell() {
        app.launch()
        let firstCell = XCUIApplication().tables.cells.firstMatch
        XCTAssertTrue(firstCell.isHittable)
        firstCell.tap()
        firstCell.buttons["delete_button"].tap()
        XCTAssertFalse(firstCell.isHittable)
    }

}

private extension XCUIApplication {
    var isUsersView: Bool {
        return otherElements["usersView"].exists
    }

    var isErrorLoadingView: Bool {
        return otherElements["errorLoadingView"].exists
    }
}
