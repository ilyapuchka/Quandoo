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

class CachingUserRepository: UserRepository, CacheServer {
    
    let repository: UserRepository
    let store: Store
    
    init(repository: UserRepository, store: Store) {
        self.repository = repository
        self.store = store
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        let users = Variable<[User]>(
            get: { return self.store.users },
            set: { self.store.users = $0 }
        )
        serveCached(users, updateCache: { repository.getUsers(completion: $0) }, completion: completion)
    }

}
