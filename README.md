# PlatinumlistSDK-IOS
## Requirements
iOS 11.0+ / macOS 10.15+
Swift 5.0+

For some types of tickets user need to upload photo from camera, so to avoid  the crash add `NSCameraUsageDescription` in your project Info.plist

## Installation
### CocoaPods
Add this to your Podfile 
```ruby
pod 'PlatinumlistSDK', :git => "https://github.com/Platinumlist/PlatinumSDK-IOS.git"
```
## Usage
### Creating SMWebViewController
```ruby
let vc: SMWebViewController = .init(nibName: nil, bundle: nil)
```
### Creating SMUser
```ruby
let user: SMUser = SMUser(name: "Some Name", email: "mail@example.com", phone: "+971500000000", nationalityId: 123, cityId: 1)
```
- **name** - String, 5 - 200 chars
- **email** - String, 5 - 200 chars
- **phone** - String, expect valid phone number
- **nationalityId** - Int, [Method returns available nationality ids](https://docs.platinumlist.net/api/v7/#country-country-list-get)
- **cityId** - Int, [Method returns available city ids](https://docs.platinumlist.net/api/v7/#city-city-list)

### Setup SMUser to SMWebViewController
```ruby
vc.processCheckout(user)
```
SMUser saves in UserDefaults 

### Remove SMUser from UserDefaults
```ruby
vc.removeCurrentUser()
```

 `When the first ticket was added the basket has expiration time equal 15 minutes.`

### Setting Parameters to SMWebViewController

```ruby
public func setParameters(sdk: SDKType,
                          accessToken: String,
                          eventId: String?,
                          eventShowId: String?,
                          eventShowSetting: Bool?,
                          user: SMUser?,
                          language: SMLanguage?,
                          completion: SMResultCallback)
```
Required parameters: 

- **sdk** - SDKType, `purchase|ticketOffice|selectTickets` - SDK type
- **accessToken**- String
- **eventId**- String? - event ID
- **eventShowId**- String? - event's show ID

Use **eventId** or **eventShowId** separately. 

Optional parameters:

- **eventShowSetting** - Bool? - is needed event show setting (used if event show ID was setted, true by default)
- **user**- SMUser? - user for basket, if it wasn’t setted separately (importent! User used to be setted before SMWebView presentation)
- **language**- SMLanguage?, `en|ar` - language ( `en` by default)

Completion - SMResultCallback:

```ruby
public typealias SMResultCallback = ((_ result: SMResult?, _ error: SMError?) -> Void)

public enum SMResult {
    case addUser
    case orderStatus(_ status: String?, id: Int)
    case errorMessage(_ message: String?, code: Int)
    case goBack
    case close
    case apple
}

public enum SMError: Error {
    case wrongParameters
    case applePayAuthorization
    case applePayTransaction
    case unknown
}
```

Example:

```ruby
let toket: String = "Some token"
let idEventStr: String = "11634"
let language: SMLanguage = SMLanguage.ar
vc.setParameters(sdk: sdkType, accessToken: token, eventId: idEventStr, language: language) { [weak self] (result, error) in

    if let error: SMError = error {
        // handle error 
    }

    if let result: SMResult = result {

        switch result {
        case .addUser:
        
            // the last chanse to add user to process checkout
            // to do this create and setup SMUser to your SMWebViewController
        case .orderStatus(let status, let orderId):

            // handle order status 
        case .errorMessage(let message, let code):
            
            // handle error message
        case .goBack:

            // handle go back
        case .close:
            
            // handle close
        case .apple:
            
            // handle apple
        @unknown default:
          print("unknown")
        }
    }
}
```

**orderStatus**:
 - **orderId** - Int
 - **status** - String, `completed|expired|pending payment|failed` - current order status
 
 **errorMessage**:
 - **message** - String? 
 - **code** - Int
 
 ### Complete Order for `selectTickets` SDK type
 
 ```ruby
 let amount: Float = 3.0
 let id: Int = 126347
 
 SMWebManager.shared.updateToCompleted(idOrder: id, amount: amount) {
 
        // Order is successfully updated to complete status
 } failure: {[weak self] (Error) in
        // handle failure
 }
 
 SMWebManager.shared.updateToFailed(idOrder: id) {[weak self] in
        // Order is successfully updated to failed status
 } failure: {[weak self] (Error) in
        // handle failure
 }
```

### Payment
For the testing purchase use `Payfort Test` payment gateway. 
[Available credit card credentials](https://paymentservices.amazon.com/docs/EN/12.html#test-payment-card-numbers)

### Order details
[Method returns info about order](https://docs.platinumlist.net/api/v7/#order-order)

### Apple Pay

We handle all payment logic in SDK, though you need only to set up your environment for integrating Apple Pay into an app.
- Create a Merchant ID
- Enable Apple Pay Payment Processing in an App ID Configuration
- Configure Apple Pay capabilities in Xcode for your project
