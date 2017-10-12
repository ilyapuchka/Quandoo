//
//  PostService.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

class PostService {
    
    let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func getPosts(withUserId userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        self.postRepository.getPosts(withUserId: userId, completion: completion)
    }
    
}
