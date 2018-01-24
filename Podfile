# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def rx_swift
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'RxRealmDataSources'
    pod 'RxRealm'
    
    # Networking
    pod 'Moya/RxSwift'
    pod 'Moya-ObjectMapper/RxSwift'
end

target 'PNPC-iOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PNPC-iOS
  rx_swift
  
  # Keyboard Manager
  pod 'IQKeyboardManagerSwift', '4.0.10'
  
  # Animations/Transitions
  pod 'Hero', '~> 0.3'

  # Firebase Cloud Messaging
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  
  pod 'NotificationBannerSwift', '1.3'

  # Estimote SDK
  # Does not work (https://github.com/Estimote/iOS-SDK/issues/269)
  # pod 'EstimoteSDK', '5.0.0-alpha.2'

  target 'PNPC-iOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PNPC-iOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
