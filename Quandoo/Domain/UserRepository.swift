//
//  UserRepository.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

protocol UserRepository {
    func getUsers(completion: @escaping ([User]?, Error?) -> Void)
}
