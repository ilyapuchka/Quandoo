//
//  APIUserRepository.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

extension URLRequest {
    static func usersRequest() -> URLRequest {
        let urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/users")!
        return URLRequest(url: urlComponents.url!)
    }
}

class APIUserRepository: UserRepository {
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        networkSession.request(.usersRequest()) { (users, _, _, error) in
            completion(users, error)
        }
    }
    
}
