# Sources configuration
source 'https://github.com/CocoaPods/Specs.git'

workspace 'StravaSwiftAPIClient'

platform :ios, '8.0'
use_frameworks!

inhibit_all_warnings!

def all_pods
    pod 'SwiftLint'
end

def test_pods
  pod 'OHHTTPStubs/Swift'
end

abstract_target 'StravaAPIClientBase' do

  all_pods

  target 'StravaAPIClient-iOS' do
  end
  target 'StravaAPIClient-macOS' do
  end
  target 'StravaAPIClient-watchOS' do
  end
  target 'StravaAPIClient-tvOS' do
  end

  target 'StravaAPIClient-iOS Tests' do
    test_pods
  end
  target 'StravaAPIClient-macOS Tests' do
  	test_pods
  end
  target 'StravaAPIClient-tvOS Tests' do
  	test_pods
  end
end
