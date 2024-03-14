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
  pod 'GzipSwift'

  target 'SudoEmailTests' do
    podspec :name => 'SudoEmail'
  end

  target 'SudoEmailIntegrationTests' do
    podspec :name => 'SudoEmail'
    pod 'SudoEntitlements', '~> 9.0'
    pod 'SudoEntitlementsAdmin', '~> 4.1'
    pod 'SudoProfiles', '~> 17.0'
  end

end

# Fix Xcode nagging warning on pod install/update
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
  # Fix Xcode `Class <FooClass> is implemented in both <path> and <path>. One of the two will be used. Which one is undefined` warning`
  auto_process_target(['SudoEmail-SudoEmailTests', 'SudoEmail-SudoEmailIntegrationTests'], 'SudoEmail', installer)
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
end

def auto_process_target(app_target_names, embedded_target_name, installer)
    words = find_words_at_embedded_target('Pods-' + embedded_target_name,
                                          installer)
    handle_app_targets(app_target_names.map{ |str| 'Pods-' + str },
                       words,
                       installer)
end

def find_line_with_start(str, start)
    str.each_line do |line|
        if line.start_with?(start)
            return line
        end
    end
    return nil
end

def remove_words(str, words)
    new_str = str
    words.each do |word|
        new_str = new_str.sub(word, '')
    end
    return new_str
end

def find_words_at_embedded_target(target_name, installer)
    puts("target name: #{target_name}")
    target = installer.pods_project.targets.find { |target| target.name == target_name }
    puts("target #{target}")
    target.build_configurations.each do |config|
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        old_line = find_line_with_start(xcconfig, "OTHER_LDFLAGS")
        
        if old_line == nil
            next
        end
        words = old_line.split(' ').select{ |str| str.start_with?("-l") }.map{ |str| ' ' + str }
        return words
    end
end

def handle_app_targets(names, words, installer)
    installer.pods_project.targets.each do |target|
        if names.index(target.name) == nil
            next
        end
        puts "Updating #{target.name} OTHER_LDFLAGS"
        target.build_configurations.each do |config|
            xcconfig_path = config.base_configuration_reference.real_path
            xcconfig = File.read(xcconfig_path)
            old_line = find_line_with_start(xcconfig, "OTHER_LDFLAGS")
            
            if old_line == nil
                next
            end
            new_line = remove_words(old_line, words)
            
            new_xcconfig = xcconfig.sub(old_line, new_line)
            File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
        end
    end
end
