//
//  UserDefaults+KeyValuePersistentStorage.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

import Foundation

extension UserDefaults: KeyValuePersistentStorage {}
extension KeyValuePersistentStorage where Self: UserDefaults {
    
    /// Register Default Value for provided key in UserDefaults. synchronize() will be called every time this method called.
    ///
    /// - Parameters:
    ///   - defaultValue: with type Data
    ///   - key: unique identifier for stored data
    public func register(defaultValue: Data, for key: String) {
        self.register(defaults: [key: defaultValue])
        self.synchronize()
    }
    
    /// Perform batch operations on USerDefaults; synchronize() will be called once after all operations performed
    ///
    /// - Parameter operation: operations ( register(defaultValue: , for key: ), setData(_ data: , forKey key: ) )
    public func performAndWait(_ operation: (_ storage: KeyValuePersistentStorage)->Void) {
        operation(self)
        self.synchronize()
    }
    
    /// Delete all persisted items from the UserDefaults of Main Bundle persistent Domain. synchronize() will be called every time this method called.
    ///
    public func resetStorage() {
        guard let bundle = Bundle.main.bundleIdentifier else { return }
        removePersistentDomain(forName: bundle)
        self.synchronize()
    }
    
    
    /// Set data for provided key in UserDefaults. synchronize() will be called every time this method called.
    ///
    /// - Parameters:
    ///   - data: data that need to be persisted.
    ///   - key:  unique identifier for stored data
    public func setData(_ data: Data?, for key: String) {
        self.set(data, forKey: key)
        self.synchronize()
    }
    
    public func removeObject(for key: String) {
        self.removeObject(forKey: key)
    }
}
