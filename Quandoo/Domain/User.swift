//
//  User.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
}
