# pod lib lint FoodInspections.podspec
Pod::Spec.new do |s|
  s.name             = "FoodInspections"
  s.version          = "1.0.4"
  s.summary          = "Library to access the v1 Food Inspections API."
  s.homepage         = "https://github.com/rnelson/FoodInspections"
  s.license          = 'MIT'
  s.author           = { "Ross Nelson" => "ross.nelson@gmail.com" }
  s.source           = { :git => "https://github.com/rnelson/FoodInspections.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/foodinspections'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'MapKit', 'CoreLocation'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
