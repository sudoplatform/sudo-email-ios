#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEmail'
  spec.version               = '3.1.0'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Email SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-email-ios.git', :tag => "v#{spec.version}" }
  spec.source_files          = 'SudoEmail/**/*.swift'
  spec.ios.deployment_target = '13.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'

  spec.dependency 'AWSAppSync', '~> 3.1'
  spec.dependency 'SudoUser', '~> 7.14'
  spec.dependency 'SudoProfiles', '~> 5.6'
  spec.dependency 'SudoLogging', '~> 0.3'
  spec.dependency 'SudoKeyManager', '~> 1.2'
  spec.dependency 'SudoOperations', '~> 3.3'
  spec.dependency 'SudoApiClient', '~> 1.4'
end
