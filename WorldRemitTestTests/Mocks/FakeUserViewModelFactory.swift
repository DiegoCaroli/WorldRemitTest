//
//  FakeUserViewModelFactory.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 07/03/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class FakeUserViewModelFactory: UserViewModelFactory {
    lazy var decimalFormatter = DecimalFormatter()
    lazy var imageCache = ImageDownloader()

    func makeUserViewModel(for user: User) -> UserViewModel {
        return UserViewModel(user: user,
                             decimalFormatter: decimalFormatter,
                             imageCache: imageCache)
    }
}
