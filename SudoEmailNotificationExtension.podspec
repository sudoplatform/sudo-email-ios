#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEmailNotificationExtension'
  spec.version               = '18.4.1'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Email SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-email-ios.git', :tag => "v#{spec.version}" }
  spec.ios.deployment_target = '15.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.7'

  spec.source_files = 'SudoEmailCommon/**/*.swift','SudoEmailNotificationExtension/**/*.swift'

  spec.dependency 'SudoLogging', '~> 1.0'
  spec.dependency 'SudoKeyManager', '~> 2.6', '>= 2.6.1'
  spec.dependency 'SudoNotificationExtension', '~> 3.0'
end
