Pod::Spec.new do |s|
  s.name         = "StravaAPIClient"
  s.version      = "0.1"
  s.summary      = "Strava Swift API Client"
  s.description  = <<-DESC
    This is a Swift implementation of the Strava Swift API Client (v3)
  DESC
  s.homepage     = "http://www.github.com/crsantos/StravaAPIClient"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Carlos Santos" => "carlosricardosantos@gmail.com" }
  s.social_media_url   = "http://www.twitter.com/crsantos"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "http://www.github.com/crsantos/StravaAPIClient.git", :tag => s.version.to_s }
  s.cocoapods_version = '>= 1.4'
  s.swift_version = '4.0'
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
