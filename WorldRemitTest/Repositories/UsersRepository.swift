//
//  UsersRepository.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 06/03/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import Foundation

protocol UsersRepository {
    func getUsers(completion: @escaping (Result<Users, Error>) -> Void)
}
