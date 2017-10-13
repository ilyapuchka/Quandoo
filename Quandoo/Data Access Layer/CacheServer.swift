//
//  Variable.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

class Store {
    var users: [User]?
    var posts: [Int: [Post]] = [:]
}

public final class Variable<T> {
    
    public let get: () -> T?
    public let set: (T?) -> Void
    
    public init(get value: @escaping () -> T?, set: @escaping (T?) -> Void) {
        self.get = value
        self.set = set
    }
}

public protocol CacheServer {
    
    /// If `cached` is not nil asynchronously calls completion block on main thread, otherwise calls `updateCache`.
    func serveCached<T>(_ cached: Variable<T>, updateCache: (@escaping (T?, Error?)->Void)->Void, completion: @escaping (T?, Error?) -> Void)
    
}

extension CacheServer {
    
    public func serveCached<T>(_ cached: Variable<T>, updateCache: (@escaping (T?, Error?)->Void)->Void, completion: @escaping (T?, Error?) -> Void) {
        if let cached = cached.get() {
            DispatchQueue.main.async {
                completion(cached, nil)
            }
        } else {
            updateCache({ response, error in
                if let response = response {
                    cached.set(response)
                }
                completion(response, error)
            })
        }
    }
    
}
