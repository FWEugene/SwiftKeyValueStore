//
//  SimpleKeychainWrapper_Test.swift
//  SimpleUserDefaults_ExampleTests
//
//  Created by Yevgeniy Prokoshev on 25/07/2018.
//  Copyright © 2018 FutureWorkshops. All rights reserved.
//

import XCTest
@testable import SwiftKeyValueStore
import SwiftKeychainWrapper

private var SecureKeyValueStore = KeychainWrapper.standard

class SimpleKeychainWrapper_Test: XCTestCase {
    
    func testCodableStruct() {
        let structKey = KeyValueStoreKey<MyStruct>("structValue")
        
        let user = MyStruct(name: "asd", secondName: "asdasd", codable: AnotherStruct(name: "asdad", secondName: "asdasd"))
        SecureKeyValueStore.save(user, forKey: structKey)
        
        XCTAssert(SecureKeyValueStore.get(forKey: structKey) == user)
    }
    
    func testInt() {
        let intKey = KeyValueStoreKey<Int>("intValue")
        SecureKeyValueStore.save(123, forKey: intKey)
        
        XCTAssert(SecureKeyValueStore.get(forKey: intKey) == 123)
    }
    
    func testArrayOfString() {
        
        let arrayOfStringsKey = KeyValueStoreKey<Array<String>>("arrayOfStringsKey")
        
        let stringsArray = ["123", "234", "String"]
        SecureKeyValueStore.save(stringsArray, forKey: arrayOfStringsKey)
        
        XCTAssert(SecureKeyValueStore.get(forKey: arrayOfStringsKey) == stringsArray)
    }
    
    func testSetOfInts() {
        let intsSetKey = KeyValueStoreKey<Set<Int>>("SetOfInt")
        
        let intSet = Set([123, 234, 456])
        SecureKeyValueStore.save(intSet, forKey: intsSetKey)
        
        XCTAssert(SecureKeyValueStore.get(forKey: intsSetKey) == intSet)
    }
    
    func testRegister () {
        let stringsArray = ["123", "234", "String"]
        
        let stringsArrayKey = KeyValueStoreKey<Array<String>>("StringsArray")
        SecureKeyValueStore.register(defaultValue: stringsArray, for: stringsArrayKey)
        
        XCTAssert(SecureKeyValueStore.get(forKey: stringsArrayKey) == stringsArray)
    }
    
    func testCodableSubscript() {
        
        let structsArray = KeyValueStoreKey<Array<MyStruct>>("StructsArray")
        
        let user = MyStruct(name: "asd", secondName: "asdasd", codable: AnotherStruct(name: "asdad", secondName: "asdasd"))
        SecureKeyValueStore.save([user], forKey: structsArray)
        
        let user_1 = MyStruct(name: "asd", secondName: "asdasd", codable: AnotherStruct(name: "asdad", secondName: "asdasd"))
        SecureKeyValueStore[structsArray]?.append(user_1)
        
        let newArray = SecureKeyValueStore[structsArray]
        
        XCTAssert(newArray?.count == 2)
    }
    
    func testNSCodingNotNill() {
        let profileKey = KeyValueStoreKey<Profile>("Profile")
        let profile = Profile(name: "Foo", age: 23)
        
        SecureKeyValueStore.save(profile, forKey: profileKey)
        guard let _ = SecureKeyValueStore.get(forKey: profileKey) else { XCTFail(); return }
        
    }
    
    func testNSCodingSame () {
        let profileKey = KeyValueStoreKey<Profile>("Profile")
        let profile = Profile(name: "Foo", age: 23)
        
        SecureKeyValueStore.save(profile, forKey: profileKey)
        guard let decodedProfile = SecureKeyValueStore.get(forKey: profileKey) else { XCTFail(); return}
        
        XCTAssert((decodedProfile.name == profile.name && decodedProfile.age == profile.age))
    }
    
    func testNSCodingSubscript () {
        let profileKey = KeyValueStoreKey<Profile>("Profile")
        let profile = Profile(name: "Foo", age: 23)
        
        SecureKeyValueStore[profileKey] = profile
        guard let decodedProfile = SecureKeyValueStore.get(forKey: profileKey) else { XCTFail(); return}
        
        XCTAssert((decodedProfile.name == profile.name && decodedProfile.age == profile.age))
    }
    
    
    func testResetStorage() {
        
        let profileKey = KeyValueStoreKey<Profile>("Profile")
        let profile = Profile(name: "Foo", age: 23)
        
        SecureKeyValueStore[profileKey] = profile
        
        guard let decodedProfile = SecureKeyValueStore.get(forKey: profileKey) else { XCTFail(); return}
        XCTAssert((decodedProfile.name == profile.name && decodedProfile.age == profile.age))
        
        SecureKeyValueStore.resetStorage()
        guard let _ = SecureKeyValueStore.get(forKey: profileKey) else { return }
        XCTFail();
    }
    
    func testDefaultPrimitiveValue() {
        
        let intKeyWithDefaultValue = KeyValueStoreKey<Int>("IntWithDefault", defaultValue: 222)
        guard let decodedIntDefault = SecureKeyValueStore.get(forKey: intKeyWithDefaultValue) else { XCTFail(); return}
        
        XCTAssert(decodedIntDefault == 222)
    }
    
    
    func testDefaultStructValue() {
        let DefaultStruct = AnotherStruct(name: "DefaultName", secondName: "DefaultSecondName")
        let structKeyWithDefaultValue = KeyValueStoreKey<AnotherStruct>("defaultStruct", defaultValue: DefaultStruct)
        
        guard let decodedStructDefault = SecureKeyValueStore.get(forKey: structKeyWithDefaultValue) else { XCTFail(); return}
        XCTAssert(decodedStructDefault.name == "DefaultName" && decodedStructDefault.secondName == "DefaultSecondName")
    }
}
