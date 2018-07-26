//
//  KeyValueStore+Implementation.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

import Foundation

public extension KeyValueStore {
    
    
    /// Register the value of the specified default key. KeyValueStoreKey<ValueType> ValueType has to be same type as Default Value. Value has to conform Codable protocol.
    ///
    /// - Parameters:
    ///   - defaultValue: default value with type specified in KeyValueStoreKey<T> type
    ///   - key: key constrained to type. Type has to conform Codable protocol
    ///
    public func register<ValueType>(defaultValue: ValueType, for key: KeyValueStoreKey<ValueType>) where ValueType: Codable {
        
        if let encoded = try? JSONEncoder().encode([key.rawValue: defaultValue]) {
             persistentStore.register(defaultValue: encoded, for: key.rawValue)
        }
    }
 
    
    /// Remove data from the prersistent storage for a given KeyValueStoreKey specified key.
    ///
    /// - Parameter key: KeyValueStoreKey constrained to stored value type
    ///
    public func remove<ValueType>(key: KeyValueStoreKey<ValueType>) {
        persistentStore.removeObject(for: key.rawValue)
    }
    

    /// Save the value of the specified key to the persistent storage. Value has to conform Codable protocol. KeyValueStoreKey<ValueType> ValueType has to be same type as Default Value.
    ///
    /// - Parameters:
    ///   - value: value has to conform Codable protocol
    ///   - key: KeyValueStoreKey key
    ///
    public func save<ValueType>(_ value: ValueType?, forKey key: KeyValueStoreKey<ValueType>) where ValueType: Codable {
        guard let value = value else {
            persistentStore.setData(nil, for: key.rawValue)
            return
        }
        guard let encoded = try? JSONEncoder().encode([key.rawValue: value]) else { return }
        persistentStore.setData(encoded, for: key.rawValue)
    }
    
    
    /// Get value for specified key.
    ///
    /// - Parameter key: KeyValueStoreKey constrained to returned value type
    /// - Returns: Optional Value if value does not exist. Use Non Optional return method for ValueTypes conforms to DefaultValueRepresentable.
    ///
    public func get<ValueType>(forKey key: KeyValueStoreKey<ValueType>) -> ValueType?  where ValueType: Codable {
        guard let value = persistentStore.data(forKey: key.rawValue) else { return key.defaultValue }
        
        if let result = try? JSONDecoder().decode([String: ValueType].self, from: value) {
            return result[key.rawValue]
        }
        return key.defaultValue
    }
}


// NSCoding

public extension KeyValueStore {
    
    /// Register the value of the specified default key. KeyValueStoreKey<ValueType> ValueType has to be same type as Default Value. Value has to conform NSCoding protocol.
    ///
    /// - Parameters:
    ///   - defaultValue: default value with type specified in KeyValueStoreKey<T> type
    ///   - key: key constrained to type. Type has to conform NSCoding protocol
    ///
    public func register<ValueType>(defaultValue: ValueType, for key: KeyValueStoreKey<ValueType>) where ValueType: NSObject & NSCoding {
        let data = NSKeyedArchiver.archivedData(withRootObject: defaultValue)
        persistentStore.register(defaultValue: data, for: key.rawValue)
    }
    
    
    /// Save the value of the specified key to the persistent storage. Value has to conform NSCoding protocol. KeyValueStoreKey<ValueType> ValueType has to be same type as Default Value.
    ///
    /// - Parameters:
    ///   - value: value has to conform NSCoding protocol
    ///   - key: KeyValueStoreKey key
    ///
    public func save<ValueType>(_ value: ValueType?, forKey key: KeyValueStoreKey<ValueType>) where ValueType: NSObject & NSCoding {
        guard let value = value else {
            persistentStore.setData(nil, for: key.rawValue)
            return
        }
        let encoded = NSKeyedArchiver.archivedData(withRootObject: value)
        persistentStore.setData(encoded, for: key.rawValue)
    }
    
    
    /// Get value for specified key.
    ///
    /// - Parameter key: KeyValueStoreKey constrained to returned value type
    /// - Returns: Optional Value if value does not exist. Value type has to conform NSCoding protocol
    ///
    public func get<ValueType>(forKey key: KeyValueStoreKey<ValueType>) -> ValueType?  where ValueType: NSObject & NSCoding {
        guard let value = persistentStore.data(forKey: key.rawValue) else { return key.defaultValue }
        
        if let result = NSKeyedUnarchiver.unarchiveObject(with: value) as? ValueType {
            return result
        }
        return key.defaultValue
    }

}
