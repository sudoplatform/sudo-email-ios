#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEmail'
  spec.version               = '10.0.1'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Email SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-email-ios.git', :tag => "v#{spec.version}" }
  spec.source_files          = 'SudoEmail/**/*.swift'
  spec.vendored_frameworks   = ['Frameworks/MailCore.framework']
  spec.preserve_paths        = 'Frameworks/*.framework'
  spec.ios.deployment_target = '15.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'

  # workaround for pod publishing failure
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  spec.dependency 'AWSAppSync', '~> 3.6.1'
  spec.dependency 'AWSCore', '~> 2.27.15'
  spec.dependency 'AWSS3', '~> 2.27.15'
  spec.dependency 'SudoConfigManager', '~> 3.0.2'
  spec.dependency 'SudoUser', '~> 15.1'
  spec.dependency 'SudoLogging', '~> 1.0'
  spec.dependency 'SudoKeyManager', '~> 2.5'
  spec.dependency 'SudoApiClient', '~> 10.1.0'
  
  spec.xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/SudoEmail/Frameworks/"',
    'OTHER_LDFLAGS'          => '"-ObjC"'
  }
end
