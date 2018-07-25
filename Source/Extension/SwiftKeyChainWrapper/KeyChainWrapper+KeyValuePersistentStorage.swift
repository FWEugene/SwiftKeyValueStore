//
//  KeyChainWrapper+KeyValuePersistentStorage.swift
//  Pods-SimpleUserDefaults_Example
//
//  Created by Yevgeniy Prokoshev on 25/07/2018.
//

import Foundation
import SwiftKeychainWrapper


extension KeychainWrapper: KeyValuePersistentStorage {}
extension KeyValuePersistentStorage where Self: KeychainWrapper {
    
    
    // Set data for provided key in KeyChain.
    ///
    /// - Parameters:
    ///   - data: data that need to be persisted in KeyChain.
    ///   - key:  unique identifier for stored data
    public func setData(_ data: Data?, for key: String) {
        guard let data = data else { return }
        self.set(data, forKey: key)
    }
    
    /// Returns a Data object from KeyChain for provided key
    ///
    /// - Parameter key: key to lookup for data
    /// - Returns: Data assosiated with key if exist. If no data exists, or the data found cannot be encoded as a string, returns nil.
    public func data(forKey key: String) -> Data? {
        return self.data(forKey: key, withAccessibility: nil)
    }
    
    /// Register Default Value for provided key in KeyChain. If value has been previously regitered or set, this method does nothing.
    ///
    /// - Parameters:
    ///   - defaultValue: with type Data
    ///   - key: unique identifier for stored data
    public func register(defaultValue: Data, for key: String) {
        if self.hasValue(forKey: key) { return }
        setData(defaultValue, for: key)
    }
    
    public func removeObject(for key: String) {
        self.removeObject(forKey: key, withAccessibility: nil)
    }
    
    /// Delete all persisted items added through KeyValueStore.
    ///
    public func resetStorage() {
        let _ = self.removeAllKeys()
    }
    
    /// Perform batch operations on KeyChain
    ///
    /// - Parameter operation: operations ( register(defaultValue: , for key: ), setData(_ data: , for key: ) )
    public func performAndWait(_ operation: (KeyValuePersistentStorage) -> Void) {
        operation(self)
    }
}

