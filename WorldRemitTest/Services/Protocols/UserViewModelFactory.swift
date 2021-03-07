//
//  UserViewModelFactory.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 07/03/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

protocol UserViewModelFactory {
    func makeUserViewModel(for user: User) -> UserViewModel
}
