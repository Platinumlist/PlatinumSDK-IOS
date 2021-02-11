# PlatinumSDK-IOS
## Requirements
iOS 12.0+ / macOS 10.15+
Swift 5.0+
## Installation
### CocoaPods
Add this to your Podfile 
```ruby
pod 'PlatinumSDK', :git => "https://github.com/Platinumlist/PlatinumSDK-IOS.git"
```
## Usage
### Creating SMWebViewController
```ruby
let vc: SMWebViewController = .init()
```
### Creating SMUser
```ruby
let user: SMUser = SMUser(name: "Some Name", email: "mail@example.com", phone: "+971500000000", nationalityId: 123, cityId: 1)
```
### Setting Parameters to SMWebViewController
```ruby
vc.setParameters(accessToken: token, eventId: String(model.identifier), user: user) { [weak self] (result, error) in
  if let error: SMError = error {
      // handle error 
  }
  if let result: SMResult = result {
    switch result {
    case .checkOut:
          // handle check out
    case .goBack:
          // handle go back
    }
  }
}
```
