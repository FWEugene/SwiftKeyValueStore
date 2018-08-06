
Pod::Spec.new do |s|

  s.name         = "SwiftKeyValueStore"
  s.version      = "0.1.1"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.summary      = "Simple Key Value Store. Wrapper for UserDefaults and KeyChain. Written in Swift."
  s.description  = "Use SwiftKeyValueStore api if you want type-safe, easy to use database to persist data across launches of your app."
  s.homepage     = "https://github.com/FWEugene/SwiftKeyValueStore"
  s.author       = { "Yevgeniy Prokoshev" => "yevgeniy@futureworkshops.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => 'https://github.com/FWEugene/SwiftKeyValueStore.git', :tag => s.version.to_s  }
  s.requires_arc = true
  s.swift_version = "4.0"
  s.cocoapods_version = '>= 1.5.0'
  s.source_files  = "Source/**/*.swift"
  s.dependency 'SwiftKeychainWrapper'

end

