//
//  UsersResponse.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

struct Users: Decodable {
    var items: [User]
}

struct User: Decodable {
    let reputation: Int
    let profileImage: URL
    let displayName: String

    var isBlocked = false
    var isFollowed = false

    enum CodingKeys: String, CodingKey {
        case reputation, profileImage, displayName
    }

}
