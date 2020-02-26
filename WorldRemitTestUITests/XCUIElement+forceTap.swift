//
//  XCUIElement+forceTap.swift
//  WorldRemitTestUITests
//
//  Created by Diego Caroli on 27/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
