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

final public class KeyValueStoreKey<Type>: KeyValueStoreKeys, Hashable, ExpressibleByStringLiteral {
   
    public typealias StringLiteralType = String
    public static func == (lhs: KeyValueStoreKey<Type>, rhs: KeyValueStoreKey<Type>) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.hashValue == rhs.hashValue
    }
    
    public var hashValue: Int
    public var rawValue: String
    public var defaultValue: Type?
    
    public init(stringLiteral value: String) {
        self.rawValue = value
        self.hashValue = value.hashValue
    }
    
    public convenience init(stringLiteral value: String, defaultValue: Type) {
        self.init(stringLiteral: value)
        self.defaultValue = defaultValue
    }
}


public extension String {
    
    public func toKey<ValueType>(default value: ValueType) -> KeyValueStoreKey<ValueType> {
        return KeyValueStoreKey<ValueType>(stringLiteral: self, defaultValue: value)
    }
    
    public func toKeyWithType<ValueType>(_ type: ValueType.Type) ->  KeyValueStoreKey<ValueType> {
        return KeyValueStoreKey<ValueType>(stringLiteral: self)
    }
}





