//
//  UserService.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

class UserService {
    let userRepository: UserRepository
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        self.userRepository.getUsers(completion: completion)
    }
}
