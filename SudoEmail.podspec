#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEmail'
  spec.version               = '14.4.0'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Email SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-email-ios.git', :tag => "v#{spec.version}" }
  spec.ios.deployment_target = '15.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.7'

  spec.xcconfig = {
      'OTHER_LDFLAGS'          => '"-ObjC"'
  }

  spec.source_files = 'SudoEmailCommon/**/*.swift','SudoEmail/**/*.swift'

  spec.dependency 'AnonyomeMailCore2', '~> 0.6.4'
  spec.dependency 'AWSAppSync', '~> 3.6.1'
  spec.dependency 'AWSCore', '~> 2.27.15'
  spec.dependency 'AWSS3', '~> 2.27.15'
  spec.dependency 'SudoConfigManager', '~> 3.0', '>= 3.0.2'
  spec.dependency 'SudoUser', '~> 15.1'
  spec.dependency 'SudoLogging', '~> 1.0'
  spec.dependency 'SudoKeyManager', '~> 2.6', '>= 2.6.1'
  spec.dependency 'SudoApiClient', '~> 10.2'
  spec.dependency 'SudoNotification', '~> 2.1'  
end
