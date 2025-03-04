#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEmail'
  spec.version               = '18.5.0'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Email SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-email-ios.git', :tag => "v#{spec.version}" }
  spec.ios.deployment_target = '15.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.7'

  # MailCore Framework does not support arm64 simulator so need to exclude that
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.xcconfig = {
    'OTHER_LDFLAGS' => '"-ObjC"'
  }

  spec.source_files = 'SudoEmailCommon/**/*.swift','SudoEmail/**/*.swift'

  spec.dependency 'AnonyomeMailCore2', '~> 0.6.4'
  spec.dependency 'AWSAppSync', '~> 3.7.1'
  spec.dependency 'AWSCore', '~> 2.36.7'
  spec.dependency 'AWSS3', '~> 2.36.7'
  spec.dependency 'SudoConfigManager', '~> 3.1'
  spec.dependency 'SudoUser', '~> 16.0'
  spec.dependency 'SudoLogging', '~> 1.0'
  spec.dependency 'SudoKeyManager', '~> 2.6', '>= 2.6.1'
  spec.dependency 'SudoApiClient', '~> 11.0'
  spec.dependency 'SudoNotification', '~> 3.0'
end
