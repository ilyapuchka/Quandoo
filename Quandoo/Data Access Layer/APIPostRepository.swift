//
//  APIPostRepository.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

extension URLRequest {
    static func postsRequest(userId: String) -> URLRequest {
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/posts")!
        let userId = userId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        urlComponents.queryItems?.append(URLQueryItem.init(name: "userId", value: userId))
        return URLRequest(url: urlComponents.url!)
    }
}

class APIPostRepository: PostRepository {
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func getPosts(withUserId userId: String, completion: @escaping ([Post]?, Error?) -> Void) {
        networkSession.request(.postsRequest(userId: userId)) { (posts, _, _ , error) in
            completion(posts, error)
        }
    }
    
}
