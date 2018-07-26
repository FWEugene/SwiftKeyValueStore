//
//  UserDefaults+KeyValueStore.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

import Foundation

extension UserDefaults: KeyValueStore {
    
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

extension KeyValueStore where Self: UserDefaults {
    
    public var persistentStore: KeyValuePersistentStorage {
        return self
    }
}




