//
//  KeyValueStore.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

/// Confrom this protocol to use custom Implementation of KeyValue Store.

public protocol KeyValueStore {
    
    /// PersistentStore is used to persist data.
    var persistentStore: KeyValuePersistentStorage { get }
    
    func register<ValueType>(defaultValue: ValueType, for key: KeyValueStoreKey<ValueType>) where ValueType: Codable
    func register<ValueType>(defaultValue: ValueType, for key: KeyValueStoreKey<ValueType>) where ValueType: NSObject & NSCoding
    
    func remove<ValueType>(key: KeyValueStoreKey<ValueType>)
    
    func save<ValueType>(_ value: ValueType?, forKey key: KeyValueStoreKey<ValueType>) where ValueType: Codable
    func save<ValueType>(_ value: ValueType?, forKey key: KeyValueStoreKey<ValueType>) where ValueType: NSObject & NSCoding


    func get<ValueType>(forKey key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType: Codable
    func get<ValueType>(forKey key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType: NSObject & NSCoding


    func performAndWait(_ operation: (KeyValuePersistentStorage)->Void)
    
    subscript<ValueType>(key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType: Codable { get set }
    subscript<ValueType>(key: KeyValueStoreKey<ValueType>) -> ValueType? where ValueType: NSObject & NSCoding { get set }
}

