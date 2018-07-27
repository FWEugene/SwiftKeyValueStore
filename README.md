# SwiftKeyValueStore

![Swift version](https://img.shields.io/badge/swift-4.0-orange.svg)

#### Type-Safe Swift API for Key-Value Store database. 

###### SwiftKeyValueStore is an extention for `UserDefaults` and `SwiftKeychainWrapper` to provide simple, type-safe, expressive Swifty API with the benefits of static typing. Chose what type of the database you want to use - unencrypted `UserDefaults` or encrypted storage in `KeyChain`. Define your keys in one place, use value types easily, and get extra safety and convenient compile-time checks for free.


# Version 0.1
### Features

**There's only three steps to using SwiftKeyValueStore:**

Step 1: Chose Storage type `UserDefaults`. Use `standard` shared instance or create new instance. 

```swift
var DefaultsKeyValueStore = UserDefaults.standard
```

Or encrypted storage in `KeyChain`. Use `standard` shared instance or create new instance. 
```swift
var KeychainKeyValueStore = KeychainWrapper.standard
```

Step 2: Define your keys.  

```swift
extension KeyValueStoreKeys {
    static let userName = KeyValueStoreKey<String>("UserNameKey")
    static let onboardingIsEnabled = KeyValueStoreKey<Bool>("OnboardingIsEnabledKey")
}
```

Step 3: Use it

```swift
//Set and get Keychain.
KeychainKeyValueStore[.userName] = "user@name.com"
let username = KeychainKeyValueStore[.userName]

//Set and get User defaults 
DefaultsKeyValueStore[.onboardingIsEnabled] = true

// Modify value types in place
DefaultsKeyValueStore[.launchCount] += 1

// Use and modify typed arrays
DefaultsKeyValueStore[.movies].append("StarWars")
DefaultsKeyValueStore[.movies][0] += " Last Jedi"

// Works with types that conform Codable or NSCoding
DefaultsKeyValueStore[.color] = UIColor.white
DefaultsKeyValueStore[.color]?.whiteComponent // => 1.0
```

The convenient dot syntax is only available if you define your keys by extending `KeyValueStoreKeys` class. Or just pass the `KeyValueStoreKey` value in square brackets. Or use String to create key with specified `ValutType` or default Value. 

## Usage

### Define your keys

Define your user keys for your own convinience:

```swift
let userKey = KeyValueStoreKey<User>("userKey")
let colorKey = "ColorKey".toKeyWith(type: UIColor)
let profilesKey = "ProfilesKey".toKeyWith(defaultValue: Array<Profile>())
```

Create a `KeyValueStoreKey` object, provide the type of the value you want to store and the key name in parentheses.
Or use `String` extension for your convinience to create `KeyValueStoreKey` from `String`


Create Instance of your store. You can use `UserDefault`s store or `KeyChainWrapper` store.

```swift 
var KeychainKeyValueStore = KeychainWrapper.standard
var DefaultsKeyValueStore = UserDefaults.standard
```
Now use the your store to access those values:

```swift
// store in UserDefaults
DefaultsKeyValueStore[colorKey] = "red"
DefaultsKeyValueStore[colorKey] // => UIColor.red, typed as UIColor?

// store securely in KeyChain
KeychainKeyValueStore[userKey] = User(firstName: "Yuriy", 
                                      lastName: "Gagarin") // struct User has to conform `Codable` protocol 
KeychainKeyValueStore[userKey] // => (firstName: "Yuriy", 
                                      lastName: "Gagarin"), typed as User?
```

The compiler would not let you to set a wrong value type, and alwasy returns expected optional type.


### Supported types

SwiftKeyValueStore supports all of the standard `NSUserDefaults` types, like strings, numbers, booleans, arrays and dictionaries. As well as any types the conforms Codable or NSCoding protocol

#### Codable

`SwiftKeyValueStore` support `Codable`. Just add `Codable` protcol conformance to your type, like:
```swift
struct User: Codable {
    let firstName: String
    let lastName: String
}
```

You've got Array support for free:
```swift
let users = KeyValueStoreKey<[User]>("users")
```

#### NSCoding

`SwiftKeyValueStore` support `NSCoding`. Just add `NSCoding` protcol conformance to your type and implement required methods:
```swift
class UserProfileView: UIView, NSCoding  {
    let userID: String

    init(frame: CGRect, id: String) {
        self.userID = id
        super.init(frame: frame)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: "UserProfileView.Id")
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: "UserProfileView.Id") as? String else { return nil }
        self.userID = id
        super.init(coder: aDecoder)
    }
}
```

#### Default values

```swift
let counter = KeyValueStoreKey<Int>("counterKey", defaultValue: 0)
let user = KeyValueStoreKey<User>("token", defaultValue: User(firstName: "Anakin", 
                                                              lastName: "Skywalker"))
```


### Remove all keys

To reset user defaults, use `resetStorage` method.

```swift
DefaultsKeyValueStore.resetStorage()
```

### Shared user defaults

If you're sharing your user defaults between different apps or an app and its extensions, you can create you onw instance of UserDefaults or KeyChainWrapper.

```swift
var CustomSharedDefaults = UserDefaults(suiteName: "my.amazing.app")!
```

## Installation

#### CocoaPods

If you're using CocoaPods, just add this line to your Podfile:

```ruby
pod 'SwiftKeyValueStore'
```

Install by running this command in your terminal:

```sh
pod install
```
Then import the library in all files where you use it:

```swift
import SwiftKeyValueStore
```
SwiftKeyValueStore is available under the MIT license. See the LICENSE file for more info.
