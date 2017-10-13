//
//  APIPostRepository.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

extension URLRequest {
    static func postsRequest(userId: Int) -> URLRequest {
        return request(URLComponents().with {
            $0.path = "/posts"
            $0.queryItems = [URLQueryItem(name: "userId", value: String(userId))]
        })
    }
}

class APIPostRepository: PostRepository {
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func getPosts(withUserId userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        networkSession.request(.postsRequest(userId: userId)) { (posts, _, _ , error) in
            completion(posts, error)
        }
    }
    
}

class CachingPostRepository: PostRepository, CacheServer {
    
    let repository: PostRepository
    let store: Store
    
    init(repository: PostRepository, store: Store) {
        self.repository = repository
        self.store = store
    }
    
    func getPosts(withUserId userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        let posts = Variable<[Post]>(
            get: { return self.store.posts[userId] },
            set: { self.store.posts[userId] = $0 }
        )
        serveCached(posts, updateCache: { repository.getPosts(withUserId: userId, completion: $0) }, completion: completion)
    }
    
}
