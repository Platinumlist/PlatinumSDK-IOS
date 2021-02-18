# PlatinumSDK-IOS
## Requirements
iOS 11.0+ / macOS 10.15+
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
- **name** - string, 5 - 200 chars
- **email** - string, 5 - 200 chars
- **phone** - string, expect valid phone number
- **nationalityId** - int, [Method returns available nationality ids](https://docs.platinumlist.net/api/v7/#country-country-list-get)
- **cityId** - int, [Method returns available city ids](https://docs.platinumlist.net/api/v7/#city-city-list)

 `When the first ticket was added the basket has expiration time equal 15 minutes.`

### Setting Parameters to SMWebViewController
```ruby
let toket: String = "Some token"
let eventShowId: Int = "172704"
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

 - **orderId** - int, 
 - **status** - string, `completed|expired|pending payment` - current order status

### Payment
For the testing purchase use `Payfort Test` payment gateway. 
[Available credit card credentials](https://paymentservices.amazon.com/docs/EN/12.html#test-payment-card-numbers)

### Order details
[Method returns info about order](https://docs.platinumlist.net/api/v7/#order-order)
