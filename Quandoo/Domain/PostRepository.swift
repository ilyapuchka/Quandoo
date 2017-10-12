//
//  PostRepository.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

protocol PostRepository {
    func getPosts(withUserId userId: Int, completion: @escaping ([Post]?, Error?) -> Void)
}
