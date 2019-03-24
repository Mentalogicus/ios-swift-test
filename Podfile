source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.3'
use_frameworks!

target 'TestApp' do
  pod 'SwiftLint'
  target 'TestAppTests' do
    inherit! :search_paths
    pod 'Quick', :inhibit_warnings => true
    pod 'Nimble', :inhibit_warnings => true
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
