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
        return request(URLComponents().with { $0.path = "/users" })
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
