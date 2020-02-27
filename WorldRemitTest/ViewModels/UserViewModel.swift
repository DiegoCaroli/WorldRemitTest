//
//  UserViewModel.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

class UserViewModel {

    private var user: User
    private let decimalFormatter: DecimalFormatter
    private let imageDownloader: ImageDownloader

    var isExpand: Bool
    var name: String { user.displayName }
    var reputation: String { decimalFormatter.string(from: Decimal(user.reputation)) }

    var isBlocked: Bool {
        get { return user.isBlocked }
        set { user.isBlocked = newValue }
    }

    var isFollowed: Bool {
        get { return user.isFollowed }
        set { user.isFollowed = newValue }
    }

    var imageURL: URL { user.profileImage }

    var image: UIImage?

    init(user: User,
        decimalFormatter: DecimalFormatter,
        imageDownloader: ImageDownloader,
        isExpand: Bool = false) {
        self.user = user
        self.decimalFormatter = decimalFormatter
        self.isExpand = isExpand
        self.imageDownloader = imageDownloader
    }

    func fetchImage(completionHandler: @escaping (UIImage?) -> Void)  {
        imageDownloader.downloadImage(fromURL: imageURL) { completionHandler($0) }
    }

}
