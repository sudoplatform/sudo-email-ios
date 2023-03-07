#
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

workspace 'SudoEmail'
use_frameworks!
inhibit_all_warnings!

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

  target 'SudoEmailTests' do
    podspec :name => 'SudoEmail'
  end

  target 'SudoEmailIntegrationTests' do
    podspec :name => 'SudoEmail'
    pod 'SudoEntitlements', '~> 8.0'
    pod 'SudoEntitlementsAdmin', '~> 4.0'
    pod 'SudoProfiles', '~> 16.0'
  end

end

# Fix Xcode nagging warning on pod install/update
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
  end
end
