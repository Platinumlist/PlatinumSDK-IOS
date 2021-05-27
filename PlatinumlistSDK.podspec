Pod::Spec.new do |s|
    s.name                  = "PlatinumlistSDK"
    s.version               = "1.0.0"
    s.summary               = "PlatinumlistSDK"
    s.homepage              = "https://github.com/Platinumlist/PlatinumSDK-IOS.git"
    s.license               = 'MIT'
    s.authors               = {'semenag01' => 'semenag01@meta.ua'}
    s.source                = { :git => "https://github.com/Platinumlist/PlatinumSDK-IOS.git", :tag => "#{s.version}" }
    s.vendored_frameworks   = "PlatinumlistSDK.xcframework"
    s.platform              = :ios
end