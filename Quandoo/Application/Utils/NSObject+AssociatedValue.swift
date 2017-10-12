//
//  NSObject+AssociatedValue.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import Foundation

public extension NSObject {
    
    func associatedValue<T>(forKey key: UnsafeRawPointer!) -> T? {
        guard let object = objc_getAssociatedObject(self, key) else { return nil }
        return object as AnyObject as? T
    }
    
    func retain<T>(_ value: T?, forKey key: UnsafeRawPointer!) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func assign<T>(_ value: T?, forKey key: UnsafeRawPointer!) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    func copy<T>(_ value: T?, forKey key: UnsafeRawPointer!) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
}
