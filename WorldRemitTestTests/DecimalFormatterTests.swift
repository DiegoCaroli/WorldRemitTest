//
//  DecimalFormatterTests.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class DecimalFormatterTests: XCTestCase {

    var sut: DecimalFormatter!

    override func setUp() {
        super.setUp()

        sut = DecimalFormatter()
    }

    override func tearDown() {
        sut = nil
    }

    func testDecimalFormatter() {
        XCTAssertEqual(sut.string(from: 123456), "123,456")
    }

}

