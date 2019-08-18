Pod::Spec.new do |s|
  s.name         = "StravaAPIClient"
  s.version      = "0.3.0"
  s.summary      = "Strava Swift API Client"
  s.description  = <<-DESC
    This is a Swift implementation of the Strava Swift API Client (v3)
  DESC
  s.homepage     = "https://github.com/crsantos/StravaAPIClient"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Carlos Santos" => "carlosricardosantos@gmail.com" }
  s.social_media_url   = "http://www.twitter.com/crsantos"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source = { :git => "https://github.com/crsantos/StravaAPIClient.git",
               :tag => s.version.to_s,
               :submodules => true
  }
  s.cocoapods_version = '>= 1.7'
  s.swift_version = '5.0'
  s.source_files  = ["Sources/**/*.swift", "Vendor/CRNetworking/Sources/**/*.swift"]
  s.frameworks  = "Foundation"
end
