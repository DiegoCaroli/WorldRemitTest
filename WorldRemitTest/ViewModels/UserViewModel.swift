//
//  UserViewModel.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

class UserViewModel {

    private var user: User
    private let decimalFormatter: DecimalFormatter

    var isExpand: Bool
    var name: String { user.displayName }
    var reputation: String { decimalFormatter.string(from: Decimal(user.reputation)) }
    var imageURL: URL { user.profileImage }

    var isBlocked: Bool {
        get { return user.isBlocked }
        set { user.isBlocked = newValue }
    }

    var isFollowed: Bool {
        get { return user.isFollowed }
        set { user.isFollowed = newValue }
    }

    init(user: User,
        decimalFormatter: DecimalFormatter, isExpand: Bool = false) {
        self.user = user
        self.decimalFormatter = decimalFormatter
        self.isExpand = isExpand
    }

}
