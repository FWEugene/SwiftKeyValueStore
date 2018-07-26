//
//  KeyValuePersistentStorage.swift
//  SimpleUserDefaults
//
//  Created by Yevgeniy Prokoshev on 20/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//


/// Confrom this protocol to provide a specific storage for example SQL storage.

public protocol KeyValuePersistentStorage {
    func setData(_ data: Data?, for key: String)
    func data(forKey: String) -> Data?
    func register(defaultValue: Data, for key: String)
    func removeObject(for key: String)
    func resetStorage()
    func performAndWait(_ operation:(KeyValuePersistentStorage)->Void)
}


