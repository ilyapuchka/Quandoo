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
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/posts")!
        urlComponents.queryItems?.append(URLQueryItem.init(name: "userId", value: String(userId)))
        return URLRequest(url: urlComponents.url!)
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
