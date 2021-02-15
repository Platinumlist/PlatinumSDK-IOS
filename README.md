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
name - string, 5 - 200 chars
email - string, 5 - 200 chars
phone - expect valid phone number
nationalityId - int
cityId - int

### Setting Parameters to SMWebViewController
```ruby
let toket: String = "Some token"
let showID: Int = "172704"
vc.setParameters(accessToken: token, eventShowId: showID, user: user) { [weak self] (result, error) in
  if let error: SMError = error {
      // handle error 
  }
  if let result: SMResult = result {
    switch result {
    case .orderStatus(let status, let orderId):
          // handle order status
    case .goBack:
          // handle go back
    }
  }
}
```
