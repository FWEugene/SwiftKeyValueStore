//
//  KeyChainWrapper+KeyValueStore.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 25/07/2018.
//

import Foundation
import SwiftKeychainWrapper


extension KeychainWrapper: KeyValueStore {
    
    /// Public Subscript for Optional Value that conforms Codable
    ///
    public subscript<ValueType>(key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType : Decodable, ValueType : Encodable {
        get { return get(forKey: key) }
        set { save(newValue, forKey: key) }
    }
    
    /// Public Subscript for Optional Value that inherits from NSObject conforms NSCoding
    ///
    public subscript<ValueType>(key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType : NSObject, ValueType : NSCoding {
        get { return get(forKey: key) }
        set { save(newValue, forKey: key) }
    }
}

extension KeyValueStore where Self: KeychainWrapper {
    
    public var persistentStore: KeyValuePersistentStorage {
        return self
    }
}
