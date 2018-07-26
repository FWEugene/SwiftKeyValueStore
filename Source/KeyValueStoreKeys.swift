//
//  KeyValueStoreKeys.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

import Foundation


open class KeyValueStoreKeys {
    fileprivate init() {}
}

final public class KeyValueStoreKey<Type>: KeyValueStoreKeys, Hashable {
   
    public typealias StringLiteralType = String
    public static func == (lhs: KeyValueStoreKey<Type>, rhs: KeyValueStoreKey<Type>) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.hashValue == rhs.hashValue
    }
    
    public var hashValue: Int
    public var rawValue: String
    public var defaultValue: Type?
    
    public init(_ key: String) {
        self.rawValue = key
        self.hashValue = key.hashValue
    }
    
    public convenience init(_ key: String, defaultValue: Type) {
        self.init(key)
        self.defaultValue = defaultValue
    }
}


public extension String {
    
    public func toKeyWith<ValueType>(defaultValue value: ValueType) -> KeyValueStoreKey<ValueType> {
        return KeyValueStoreKey<ValueType>(self, defaultValue: value)
    }
    
    public func toKeyWith<ValueType>(type: ValueType.Type) ->  KeyValueStoreKey<ValueType> {
        return KeyValueStoreKey<ValueType>(self)
    }
}





