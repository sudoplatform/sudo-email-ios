#
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

workspace 'SudoEmail'
use_frameworks!
# inhibit_all_warnings!

project 'SudoEmail', {
    'Debug-Dev' => :debug,
    'Debug-QA' => :debug,
    'Debug-Prod' => :debug,
    'Release-Dev' => :release,
    'Release-QA' => :release,
    'Release-Prod' => :release
}

target 'SudoEmail' do
  inherit! :search_paths
  podspec :name => 'SudoEmail'
  pod 'GzipSwift'
  
  target 'SudoEmailTests'

  target 'SudoEmailIntegrationTests' do
    pod 'SudoEntitlements', '~> 10.0'
    pod 'SudoEntitlementsAdmin', '~> 5.0'
    pod 'SudoProfiles', '~> 17.0'

    target 'TestApp'
  end  
end

target 'SudoEmailNotificationExtension' do
  inherit! :search_paths
  podspec :name => 'SudoEmailNotificationExtension'
  
  target 'SudoEmailNotificationExtensionTests'
  target 'TestExtensionApp'
end

# Fix Xcode nagging warning on pod install/update
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
