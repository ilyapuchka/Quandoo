//
//  Post.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    var title: String
    var body: String
}
