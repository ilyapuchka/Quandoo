//
//  Address.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
}
